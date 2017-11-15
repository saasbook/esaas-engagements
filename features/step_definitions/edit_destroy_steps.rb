When /^I select "(.*)" for the enddate$/ do |date|
  ymd = date.to_s.split(' ')
  year_select = page.find(:select, "iteration[end_date(1i)]")
  month_select = page.find(:select, "iteration[end_date(2i)]")
  day_select = page.find(:select, "iteration[end_date(3i)]")
  year_select.select ymd[0]
  month_select.select ymd[1]
  day_select.select ymd[2]
end

Then /^I should see "(.*)" has button "(.*)"$/ do |date, button|
   find('tr', text: date.to_s).should have_content(button.to_s)
end