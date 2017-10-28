Given /^the following engagements exist:$/ do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |app|
  	Engagement.create(app)
  end
end

Given /^the following iterations exist:$/ do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |org|
  	Iteration.create(org)
  end
end

Given /^Iteration "(.*)" has the following customer feedback:$/ do |iter_id, table|
  table.hashes.each do |response|
    Iteration.find(iter_id).update(:customer_feedback => response)
  end
end