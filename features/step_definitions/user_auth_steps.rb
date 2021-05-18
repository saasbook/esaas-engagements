Given /^I try to logged in with my github account$/ do
	visit '/login'
	click_link "Log in with GitHub"
end

# mock behavior without stubbing OAuth
Given /^I login with github callback error$/ do
    visit '/auth/failure'
end

