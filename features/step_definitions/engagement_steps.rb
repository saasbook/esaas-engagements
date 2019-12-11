Given /^Iteration "(.*)" has the following customer feedback:$/ do |iter_id, table|
  table.hashes.each do |response|
    Iteration.find(iter_id).update(:customer_feedback => response.to_json)
  end
end

Given /^I add the following iterations:$/ do |table|
  table.hashes.each do |iteration|
    Iteration.create(iteration)
  end
end

Then /^the rating for "(.*)" should be "(.*)"$/ do |metric, rating|
  within("\##{metric}_score") do
    expect(page).to have_content(rating)
  end
end

When /^(?:|I )follow Request Feedback with id (.+)$/ do |id|
  visit new_engagement_iteration_path(Engagement.find(id))
end

When /I click on the "(.+)" option/ do |selector|
  selector.gsub!(/ /, "_")
  find('#' + selector).click
end

Then /^I should see "(.+)" inside "(.*)" options/ do |value, selector|
  selector.gsub!(/ /, "_")
  value.split(",").each do |v|
    find_field(selector).all("option").find("option[value=#{value}]")
  end
end

When /^I choose "(.*)" with number (.+)$/ do |selector, value|
  selector.gsub!(/ /, "_")
  find_field(selector).find("option[value=#{value}]").click
end

Then /^I should see "(.*)" is prefilled with number (.+)$/ do |selector, value|
  expect(page).to have_select(selector, :selected => value)
end