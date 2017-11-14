Then /^the field "(.*)" should be filled with "(.*)"$/ do |field, value|
  expect(find_field("customer_feedback[#{field}]").value).to eq value
end

Given /^I am on the "([^"]*) page$/ do |arg|
  visit arg
end

And /^I fill in category "(.*)" with value "(.*)"$/ do |category, value|
  pending
end

Given /^the following engagements exist:$/ do |table|
  table.hashes.each do |engagement|
  	Engagement.create(engagement)
  end
end

Given /^the following iterations exist:$/ do |table|
  table.hashes.each do |iteration|
  	Iteration.create(iteration)
  end
end

Then /^I should see "(.*)" has button "(.*)"$/ do |date, button|
   find('tr', text: date.to_s).should have_content(button.to_s)
end