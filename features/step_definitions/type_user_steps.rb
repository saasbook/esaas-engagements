When /^I fill in the fields as follows:$/ do |table|
 table.hashes.each do |t|
    if "#{t[:field]}" == "Type of user"
      select "#{t[:value]}" , :from => "user[type_user]"
    else
      steps %Q{When I fill in "#{t[:field]}" with "#{t[:value]}"}
    end
  end
end

Then /^I should see "(.*)" has type "(.*)"$/ do |username, type|
    find('tr', text: username.to_s).should have_content(type.to_s)
end

Then /^I should see "(.*)" has SID "(.*)"$/ do |username, sid|
    find('tr', text: username.to_s).should have_content(sid.to_s)
end

Then /^I press "(.*)" for "(.*)"$/ do |content, username|
    find('tr', text: username.to_s).click_link(content.to_s)
end