And /^I uncheck all comment types$/ do
	all("#filters input[type='checkbox']").each do |checkbox|
		checkbox.set(false)
	end
end

Given /^the following comments exist for "(.*)":$/ do |app_name, table|
	app = App.find_by_name(app_name)
	table.hashes.each do |hash|
		app.comments.create(hash)
	end
end

Then /^I should not see any comments$/ do
	expect(page).to have_no_selector('.comment', visible: true)
end

When /^debug$/ do byebug end