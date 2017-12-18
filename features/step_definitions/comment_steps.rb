require 'time'

And /^the time is "(.*)"$/ do |utc_time|
    Timecop.freeze(Time.zone.parse(utc_time))
end

Given /^I am logged in$/ do
	visit '/orgs'
	click_link "Log in with GitHub"
	visit "/apps"
end
