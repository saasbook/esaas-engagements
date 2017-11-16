Then /^I should have downloaded the engagement csv file$/ do
	page.status_code.should == 200
	page.response_headers['Content-Type'].should == "text/csv"
	header = page.response_headers['Content-Disposition']
	header.should match /^attachment/
	header.should match /filename="engagement.csv"$/
end