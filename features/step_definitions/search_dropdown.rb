When /^I click "(.*)"$/ do |selector|
	find(selector).click
end

And /^I type in "(.*)" in "(.*)"$/ do |value, field|
	find(field).set(value)
end

And /^I press enter in "(.*)"$/ do |field|
	find(field).native.send_keys(:return)
end

Then /^I should see "(.*)" inside "(.*)"$/ do |value, field|
	within(field) do
		expect(body).to have_content(value)
	end
end