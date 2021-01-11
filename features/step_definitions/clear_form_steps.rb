Then /^All text fields are empty for the form with selector "(.*)"$/ do |form_selector|
	within(form_selector) do
		all("input[type=text]").each do |text_field|
			text_field.value.should be_empty
		end
		all("textarea").each do |textarea|
			textarea.value.should be_empty
		end
	end
end

Then /^I should have filled in "(.*)" for "(.*)"$/ do |value, field|
	expect(body).to have_field(field, with: value)
end

Then /^the "(.*)" should not be checked$/ do |field|
	expect(page).to have_field(field, checked: false)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)" using ckeEditor rich editor$/ do |field, value|
  label = find('label', :text => /^#{field}$/)
  text_area = label.find(:xpath, '..//textarea')
  text_area.send_keys(value)
end
  
When /^(?:|I )fill in "([^"]*)" for "([^"]*)" using ckeEditor rich editor$/ do |value, field|
	steps %Q{
		When I fill in "#{field}" with "#{value}" using ckeEditor rich editor
	}
end

Then /^I should have filled in "(.*)" for "(.*)" using ckeEditor rich editor$/ do |value, field|
	label = find('label', :text => /^#{field}$/)
	text_area = label.find(:xpath, '..//textarea')
  expect(text_area).to have_text value
end