require 'time'

And /^the time is "(.*)"$/ do |utc_time|
    Timecop.freeze(Time.parse(utc_time))
end

Given /^I am logged in$/ do
	visit '/login'
	click_link "Log in with GitHub"
	visit "/apps"
end
