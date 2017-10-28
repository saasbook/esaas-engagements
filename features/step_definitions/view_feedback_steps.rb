Given(/^the following engagements exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |engagement|
    Engagement.create(engagement)
  end
end

Given(/^the following iterations exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |iteration|
    Iteration.create(iteration)
  end
end

When /^I fill in the "(.*)" form as follows:$/ do |fieldset, table|
  pending
end

Given /^I am on the "([^"]*) page$/ do |arg|
  visit arg
end

And /^I fill in category "(.*)" with value "(.*)"$/ do |category, value|
  pending
end
