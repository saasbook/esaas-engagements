Given(/^I am not logged in$/) do
  visit logout_path
end

# ERROR MESSAGE
Then /^creation should fail with "(.*)"$/ do |msg|
  steps %Q{
  Then I should see "#{msg}"
  }
end

Given(/^I am logged in on the "([^"]*) page$/) do |arg|
  visit "/org"
  click_link "Log in with GitHub"
  visit "/org"
end

Then /^the field "(.*)" should be empty$/ do |field|
  expect(find_field("#{field}").value).to be nil
end

Then /^I should be on the "([^"]*) page$/ do |arg|
  expect(visit arg)
end

Given /^the form is "blank"$/ do
  visit creation_path
end

Given /^an app exists with the parameters: "(.*)"$/ do |parameters|
  Params = parameters.split(“, “)
  #Pending
  #create the model with params
end

# user fields, user fields, org fields
When /^I fill in the "(.*)" fields as follows:$/ do |fieldset, table|
  table.hashes.each do |t|
    case t[:value]
    when /^select date "(.*)"$/
      steps %Q{When I select "#{$1}" as the "#{t[:field]}" date}
    when /^select "(.*)"$/
      steps %Q{When I select "#{$1}" from "#{t[:field]}"}
    when /^(un)?checked$/
      steps %Q{When I #{$1}check "#{t[:field]}"}
    when /^choose "(.*)"$/
      steps %Q{When I choose "#{$1}" for "#{t[:field]}"}
    else
      steps %Q{When I fill in "#{t[:field]}" with "#{t[:value]}"}
    end
  end
end