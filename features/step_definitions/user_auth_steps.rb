Given /^I try to logged in with my github account$/ do
	visit '/login'
	click_link "Log in with GitHub"
end