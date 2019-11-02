require 'json'

When /^I visit "(.*)"$/ do |url|
 	visit url
 end

 Then /^the JSON response should be:$/ do |json|
   expected = JSON.parse(json)
   actual = JSON.parse(page.body)
 	 actual.should == expected
 end
