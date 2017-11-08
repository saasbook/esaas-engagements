require 'csv'

App.delete_all
Engagement.delete_all
coach = User.find_by!(:email => 'fox@cs.berkeley.edu')
cs169 = Org.create!(:name => 'UCB CS169 Fox',
  :description => 'CS 169 at Berkeley',
  :url => 'http://cs169.saas-class.org',
  :contact => coach)
CSV.foreach("#{Rails.root}/db/apps.csv") do |p|
  next if p[0] =~ /semester/i || p[0] =~ /0$/
  if org = Org.where("name = ?", p[11]).try(:first)
    appname = p[3]
    app = App.where("name = ?", appname).try(:first) ||
      App.create!(
      :org => org,
      :name => appname,
      :status => :dead,
      :description => p[13] || 'NA',
      :deployment_url => p[14],
      :repository_url => p[15] || 'http://')
    coach = User.where("email = ?", p[9]).first ||
      User.create!(:name => p[10] || "Unknown", :email => p[9] || "#{appname}_unknown@email.com")
    app.engagements.create!(
      :team_number => "#{p[0]}-#{p[2]}",
      :start_date => Time.parse(p[1]),
      :coaching_org => cs169,
      :coach => coach,
      :screencast_url => p[16],
      :screenshot_url => p[17],
      :poster_url => p[19],
      :presentation_url => p[18],
      :prototype_deployment_url => p[14],
      :student_names => p[25] || "Unknown"
      )
  else
    puts "No org #{p[11]}"
  end
end
puts "#{App.all.size} apps, #{Engagement.all.size} engagements"

