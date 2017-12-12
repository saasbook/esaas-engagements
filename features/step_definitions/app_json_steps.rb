 When /^I visit "(.*)"$/ do |url|
 	visit url
 end

 Then /^the response should be:$/ do |json|
 	page.body.should == json
 end