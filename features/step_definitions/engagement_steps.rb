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