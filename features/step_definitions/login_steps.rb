When /^(?:|I )click on New App$/ do
    visit '/apps/new'
end

When /^(?:|I )will be on the New App page$/ do
    current_path = URI.parse(current_url).path
    assert_equal path_to('newapp'), current_path
end
