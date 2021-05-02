When /^(?:|I )hover the mouse over "([^"]*)" element$/ do |elem|
    page.save_and_open_screenshot(full: true)
    find(elem).hover
end

Given /^(?:|I )click the button "([^"]*)"$/ do |button|
    %{I press (button)}
end


Then /^(?:|I )should see hidden "([^"]*)"$/ do |text|
    Capybara.ignore_hidden_elements = false
    page.should have_content(text)
    Capybara.ignore_hidden_elements = true
end

Then /^(?:|I )press hidden button "([^"]*)"$/ do |button|
    Capybara.ignore_hidden_elements = false
    page.save_and_open_screenshot(full: true)
    %{I press (button)}
    Capybara.ignore_hidden_elements = true
end

When /^(?:|I )fill in hidden "([^"]*)" with "([^"]*)"$/ do |field, value|
    Capybara.ignore_hidden_elements = false
    fill_in(field, :with => value)
    Capybara.ignore_hidden_elements = true
end