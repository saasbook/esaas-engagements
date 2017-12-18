Given /^the following images exist:$/ do |table|
end

Then /^I should find an image with alternate text "(.*)"$/ do |alt_text|
	page.should have_css("img[alt='#{alt_text}']")
end