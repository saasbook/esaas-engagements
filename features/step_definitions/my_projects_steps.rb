When /^(?:|I )follow Request Change with id (.+)$/ do |id|
    visit new_my_project_edit_path(app_id: id)
end

When /I click on the "(.+)" icon/ do |locator|
  find('#' + locator).click
end

