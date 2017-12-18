Given(/^I delete the org with id "(.*)"$/) do |org_id|
	page.driver.submit :delete, "/orgs/#{org_id}", {}
end

