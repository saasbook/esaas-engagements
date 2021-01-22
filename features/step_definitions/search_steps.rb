Given(/^the following apps exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |app|
  	App.create(app)
  end
end

Given(/^the following orgs exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |org|
  	Org.create(org)
  end
end

Given(/^the following users exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |user|
  	User.create(user)
  end
end

Given(/^I search for "([^"]*)"$/) do |arg1|
  # puts body really good debugging trick
  fill_in "keyword", with: arg1
  click_on "Search"
end

Given(/^I'm logged in on the orgs page$/) do
  visit "/orgs"
  click_link "Log in with GitHub"
  visit "/orgs"
end

Given(/^I publicly search for "([^"]*)"$/) do |arg1|
  # puts body really good debugging trick
  visit "/public_search?keyword=#{arg1}"
end
