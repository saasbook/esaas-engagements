

When /^(?:|I )hover the mouse over "([^"]*)" element$/ do |elem|
    find(elem).hover
    sleep 1
    page.save_and_open_screenshot(full: true)
end

Given /^(?:|I )click the button "([^"]*)"$/ do |button|
    %{I press (button)}
end

Given /^(?:|I )click the delay delete button "([^"]*)"$/ do |button|
    find(".btn-danger").click
    sleep 1
end

Then /^(?:|I )should see hidden "([^"]*)"$/ do |text|
    Capybara.ignore_hidden_elements = false
    page.should have_content(text)
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
    sleep 1

    start_time = Time.now
    until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or 
          (start_time + 5.seconds) < Time.now do
            sleep 1
    end
end

Given /^(?:|I )wait "([^"]*)" seconds for animation$/ do |sec|
  sleep sec.to_f
end 

Given /^(?:|I )add the engagement$/ do
  find("#create").click
end

Given /^(?:|I )update the project$/ do
  find("#update").click
end

Given /^(?:|I )remove the project$/ do
  find(".select2-selection__choice__remove").click
  find(:xpath, "//html").click   # Due to behavior of drop down ,need to click empty area
end