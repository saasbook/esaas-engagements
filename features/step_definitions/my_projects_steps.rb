When /^(?:|I )follow Request Change with id (.+)$/ do |id|
    visit new_my_project_edit_path(app_id: id)
  end