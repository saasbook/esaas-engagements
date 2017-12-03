When /^(?:|I )want to edit "([^"]*)"$/ do |field|
  find('tr', text: field.to_s).click_link('Edit')
end

When /^(?:|I )want to destroy "([^"]*)"$/ do |field|
  find('tr', text: field.to_s).click_link('Destroy')
end
