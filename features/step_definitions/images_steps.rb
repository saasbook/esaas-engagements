Given /^the following images exist:$/ do |table|
	table.hashes.each do |hash|
		Image.create(hash)
	end
end

Given /^the user "(.*)" has a profile image "(.*)"$/ do |user, image|
	pending
end