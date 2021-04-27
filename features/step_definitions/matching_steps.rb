When /^(?:|I )hover the mouse over "([^"]*)" element$/ do |elem|
    page.save_and_open_screenshot(full: true)
    find(elem).hover
end

Given /^(?:|I )am on the ranking page$/ do
    visit "/matching/1"
end
