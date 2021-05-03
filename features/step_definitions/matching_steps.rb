

When /^(?:|I )hover the mouse over "([^"]*)" element$/ do |elem|
    find(elem).hover
    sleep 1
    page.save_and_open_screenshot(full: true)
end

Given /^(?:|I )click the button "([^"]*)"$/ do |button|
    %{I press (button)}
    
end

Given /^(?:|I )click the delay delete button "([^"]*)"$/ do |button|
    # %{I press (button)}
    find(".btn-danger").click
    sleep 1
end

Then /^(?:|I )should see hidden "([^"]*)"$/ do |text|
    Capybara.ignore_hidden_elements = false
    page.should have_content(text)
    page.save_and_open_screenshot(full: true)
    Capybara.ignore_hidden_elements = true
end

Then /^(?:|I )press hidden button "([^"]*)"$/ do |button|
    Capybara.ignore_hidden_elements = false
    %{I press (button)}
    sleep 2
    page.save_and_open_screenshot(full: true)
    Capybara.ignore_hidden_elements = true
end

When /^(?:|I )fill in hidden "([^"]*)" with "([^"]*)"$/ do |field, value|
    Capybara.ignore_hidden_elements = false
    fill_in(field, :with => value)
    Capybara.ignore_hidden_elements = true
end


When /^(?:|I )want to create matching with "([^"]*)" engagements$/ do |num|
    visit "/matching/new?num_engagements=#{num}"
end

Given /^(?:|I )follow first "([^"]*)"$/ do |link|
  first("#edit").click
end

Given /^(?:|I )want to submit ranking preference$/ do
    find(:xpath, "//*[@id=\"main\"]/div[4]").hover
    page.save_and_open_screenshot(full: true)

    start_time = Time.now
    until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or 
          (start_time + 5.seconds) < Time.now do
            sleep 1
    end

    page.save_and_open_screenshot(full: true)
end