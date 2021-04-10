require 'csv'

# create users and orgs
CSV.foreach("#{Rails.root}/db/user_orgs.csv", headers: true, header_converters: :symbol) do |row|
	user = User.find_or_create_by!(email: row[:user_email]) do |u|
		u.name = row[:user_name]
		u.github_uid = row[:github_uid]
		u.user_type = row[:user_type]
	end
	Org.find_or_create_by!(name: row[:org_name]) do |o|
		o.contact = user
		o.description = row[:org_description]
		o.url = row[:org_url] || (user.email !~ /gmail|berkeley.edu/ && user.email =~ /@(.*)$/ ? "http://#{$1}" : nil)
	end
end
puts "#{Org.all.size} orgs, #{User.all.size} users"

# default coach/coaching org
coach = User.find_or_create_by(email: 'fox@cs.berekley.edu') do |fox|
	fox.name = "Armando Fox"
	fox.github_uid = 'fox'
	fox.user_type = 'coach'
end
cs169 = Org.find_or_create_by(name: 'UCB CS169 Fox') do |ucbcs169|
	ucbcs169.description = 'CS 169 at UC Berkeley'
	ucbcs169.url = "http://cs169.saas-class.org"
	ucbcs169.contact = coach
end

# create orgs and engagements
CSV.foreach("#{Rails.root}/db/apps.csv",
	headers: true, header_converters: :symbol, encoding: 'iso-8859-1:utf-8') do |row|
	if org = Org.find_by_name(row[:org_name])
		app = App.find_or_create_by(name: row[:project]) do |a|
			a.org = org
			a.status = :dead
			a.description = row[:description] || 'NA'
			a.deployment_url = row[:deployment]
			a.repository_url = row[:ropo] || 'http://'
		end
		contact = User.find_or_create_by(email: row[:contact_email]) do |c|
			c.name = row[:customer] || 'Unknown'
			c.email = row[:contact_email] || "#{row[:project]}_unknown@email.com"
		end
		app.engagements.create do |e|
			e.team_number = "#{row[:semester]}-#{row[:team]}"
			e.start_date = Time.parse(row[:start_date])
			e.coaching_org = cs169
			e.coach = coach
			e.screencast_url = row[:screencast]
			e.screenshot_url = row[:link_to_poster_preview_slides_your_particular_slide_in_the_classwide_slide_deck]
			e.poster_url = row[:poster_pdf]
			e.presentation_url = row[:link_to_presentation_slides]
			e.prototype_deployment_url = row[:deployment]
			e.student_names = row[:students] || 'Unknown'

			# say only spring and summer based on csv
			semester = "#{row[:semester]}"
			e.semester = (semester[0] == "F" ? "FALL" : "SPRING") + " 20" +semester[1,3]
		end
	else
		puts "No org #{row[:org_name]}"
	end
end
puts "#{App.all.size} apps, #{Engagement.all.size} engagements"

# login mockup
User.find_or_create_by(YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml")["development"])

# create a mock matching
# 8 projects ranked by 6 teams, each team has 1 coach and 2 students
m1 = Matching.find_or_create_by(name: 'Spring 2021 CS169L') do |m|
	# STATUSES = ['Collecting Responses', 'Responses Collected', 'Completed']
	m.status = 'Responses Collected'

	# App id: 1 = Volunteer and Space rental portal integration
	#         2 = AFX Dance
	#         3 = Alz About Me
	#         4 = AMASS Media
	#         5 = Annotorious
	#         6 = ArcticVoice
	#         7 = Artist Submission Site
	#         8 = Assessment Platform
	m.projects = [1, 2, 3, 4, 5, 6, 7, 8]
	m.preferences = { 'sp21-1' => [1, 2, 3, 4, 5, 6, 7, 8], 'sp21-2' => [3, 2, 4, 1, 5, 7, 8, 6],
	 									'sp21-3' => [2, 3, 4, 5, 1, 8, 7, 6], 'sp21-4' => [1, 2, 3, 4, 5, 6, 7, 8],
									 	'sp21-5' => [5, 3, 2, 4, 6, 7, 8, 1], 'sp21-6' => [8, 7, 6, 5, 4, 3, 2, 1] }

	# each team has 1 coach and 2 students
	coach_ids = User.where(user_type: 1).limit(6).ids
	student_ids = User.where(user_type: 0).limit(12).ids
	m.teams = { 'sp21-1' => [coach_ids[0], student_ids[0], student_ids[1]],
							'sp21-2' => [coach_ids[1], student_ids[2], student_ids[3]],
							'sp21-3' => [coach_ids[2], student_ids[4], student_ids[5]],
							'sp21-4' => [coach_ids[3], student_ids[6], student_ids[7]],
							'sp21-5' => [coach_ids[4], student_ids[8], student_ids[9]],
							'sp21-6' => [coach_ids[5], student_ids[10], student_ids[11]] }

	# result initialized to 0 because App id starts from 1
	m.result = { 'sp21-1' => 0, 'sp21-2' => 0, 'sp21-3' => 0,
							 'sp21-4' => 0, 'sp21-5' => 0, 'sp21-6' => 0 }
end
