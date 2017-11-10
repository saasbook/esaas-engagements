When /^dump current page info$/ do
	p current_url
	p page.body
end

When /^PENDING:/ do
	pending
end
