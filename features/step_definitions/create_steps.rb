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
  expect(find_field("#{field}").value).to be_empty
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