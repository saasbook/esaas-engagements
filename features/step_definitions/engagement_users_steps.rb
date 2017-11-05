Given /^(?:|I )create a new engagement for "(.+)"$/ do |app_name|
  app_id = App.find_by_name("#{app_name}").id
  visit new_app_engagement_path(app_id)
end

When /^I fill in the engagement fields as follows:$/ do |table|
  table.hashes.each do |t|
    steps %Q{When I fill in "#{t[:field]}" with "#{t[:value]}"}
  end
end

Given /^I select "(.*)" as Team members$/ do |all_names|
  members = all_names.to_s.split(' ')
  selection = page.find(:select, 'engagement_user_ids')
  members.each do |member|
      selection.select member
  end
end

Given /^I want to edit the engagement for "(.*)"$/ do |team|
   find('tr', text: team.to_s).click_link('Edit')
end