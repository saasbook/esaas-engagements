

When /^(?:|I )hover the mouse over "([^"]*)" element$/ do |elem|
    page.save_and_open_screenshot(full: true)
    find(elem).hover
end

Given /^(?:|I )click the button "([^"]*)"$/ do |button|
    %{I press (button)}
    start_time = Time.now
        page.evaluate_script('jQuery.isReady&&jQuery.active==0').class.should_not eql(String) until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or (start_time + 5.seconds) < Time.now do
    sleep 1
    end
end

def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end
  
def finished_all_ajax_requests?
    request_count = page.evaluate_script("$.active").to_i
    request_count && request_count.zero?
    rescue Timeout::Error
end


Then /^(?:|I )should see hidden "([^"]*)"$/ do |text|
    Capybara.ignore_hidden_elements = false
    page.should have_content(text)
    Capybara.ignore_hidden_elements = true
end

Then /^(?:|I )press hidden button "([^"]*)"$/ do |button|
    Capybara.ignore_hidden_elements = false
    %{I press (button)}
    Capybara.ignore_hidden_elements = true
end

When /^(?:|I )fill in hidden "([^"]*)" with "([^"]*)"$/ do |field, value|
    Capybara.ignore_hidden_elements = false
    fill_in(field, :with => value)
    Capybara.ignore_hidden_elements = true
end


When /^(?:|I )want to create matching with "([^"]*)" engagements$/ do |num|
    visit "/matching/new?num_engagements=#{num}"
    page.save_and_open_screenshot(full: true)
end

Given /^(?:|I )follow first "([^"]*)"$/ do |link|
  first("#edit").click
end