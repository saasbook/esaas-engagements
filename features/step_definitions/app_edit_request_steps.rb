Given(/^the following App Edit Requests exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |app_edit_request|
  	AppEditRequest.create(app_edit_request)
  end
end

When /^(?:|I )follow the App Edit Request with id (.+)$/ do |id|
  visit show_my_approval_request_path(app_id: id)
end
