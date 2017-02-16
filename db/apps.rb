require 'CSV'

App.delete_all
Engagement.delete_all
CSV.foreach("#{Rails.root}/db/apps.csv") do |p|
  next if p[0] =~ /semester/i || p[0] =~ /0$/
  if org = Org.where("name = ?", p[11]).try(:first)
    appname = p[3]
    app = App.where("name = ?", appname).try(:first) ||
      App.create!(
      :org => org,
      :name => appname,
      :status => :inactive,
      :description => p[13],
      :deployment_url => p[14],
      :repository_url => p[15])
    app.engagements.create!(
      :team_number => p[0],
      :start_date => Time.parse(p[1]),
      :contact_name => p[10],
      :contact_email => p[9],
      :screencast_url => p[16],
      :screenshot_url => p[17],
      :poster_url => p[19],
      :presentation_url => p[18],
      :prototype_deployment_url => p[14],
      :student_names => p[25]
      )
  else
    puts "No org #{p[11]}"
  end
end
puts "#{App.all.size} apps, #{Engagement.all.size} engagements"

