Given /^the following engagements exist:$/ do |table|
  table.hashes.each do |engagement|
  	Engagement.create(engagement)
  end
end

Given /^the following iterations exist:$/ do |table|
  table.hashes.each do |iteration|
  	Iteration.create(iteration)
  end
end

Given /^Iteration "(.*)" has the following customer feedback:$/ do |iter_id, table|
  table.hashes.each do |response|
    Iteration.find(iter_id).update(:customer_feedback => response)
  end
end

Given /^I add the following iteration:$/ do |table|
  table.hashes.each do |iteration|
    Iteration.create(iteration)
  end
end