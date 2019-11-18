require 'json'

def check_required_keys(required_keys, format)
  required_keys.each do |required_key|
    required_key = required_key.to_sym
    raise ArgumentError, "format missing '#{required_key}'" unless format.key? required_key
  end
end

def create_app_sequence(format, count)
  format = format.symbolize_keys
  check_required_keys %w(name description org_id status), format
  last_index = App.count
  apps = Array.new
  (1..count).each do |n|
    suffix = last_index + n
    apps.push({
      id: suffix,
      name: "#{format[:name]}-#{suffix}",
      description: "#{format[:description]}-#{suffix}",
      org_id: format[:org_id],
      status: format[:status]
    })
  end
  App.create! apps
end

def create_org_sequence(format, count)
  format = format.symbolize_keys
  check_required_keys %w(name contact_id), format
  last_index = Org.count
  orgs = Array.new
  [1..count].each do |n|
    suffix = last_index + n
    orgs.push({
      id: suffix,
      name: "#{format[:name]}-#{suffix}",
      contact_id: format[:contact_id],
    })
  end
  Org.create! orgs
end

def create_user_sequence(format, count)
  format = format.symbolize_keys
  check_required_keys %w(id name github_uid email user_type), format
  last_index = User.count
  users = Array.new
  (1..count).each do |n|
    suffix = last_index + n
    users.push({
      id: suffix,
      name: "#{format[:name]}-#{suffix}",
      github_uid: "#{format[:github_uid]}-#{suffix}",
      email: "#{format[:email]}-#{suffix}",
      user_type: format[:user_type]
    })
  end
  User.create! users
end

def create_sequence(start, format, count)
  sequence = Array.new
  last = start + count
  (start...last).each do |suffix|
    item = Hash.new
    format.each { |k, v| item[k] = "#{v}-#{suffix}" }
    sequence.push(item)
  end
  sequence
end

=begin
Given there are 10 apps with sequence format:
  | name   | description | org_id | status  |
  | app    | description | 1      | pending |
  | app    | description | 2      | dead    |

Generates 10 apps with app names app-1, app-2 ... app-10
and description description-1, description-2, ... description-10
all associated with Org Id 1 and 'pending' status

And another 10 apps with names app-11, app-12 ... app-20
and description description-11, description-12 ... description-20
each associated with Org Id 2 and 'dead' status
=end
Given /^there (?:is|are) (\d+) (.+) with sequence format:$/ do |count, entity, format_table|
  entity = entity.singularize
  format_table.hashes.each do |format|
    send "create_#{entity}_sequence",  *[format, count]
  end
end

def appears_before(element, first, last)
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(element).to have_content(first)
  expect(element).to have_content(last)
  page.body.index(first).should be < page.body.index(last)
end

Then /^I should see the following apps in "(.*)" in the given order:$/ do |table_id, apps_table|
  table_body = page.find(:xpath, %{//*[@id="#{table_id}"]/tbody})
  header = apps_table.raw[0].each_with_index.map {|h, i| [h.to_sym, i]}.to_h
  data = apps_table.raw[1..-1]
  last_index = data.length - 1
  data.each_with_index do |_, index|
    next if index == last_index
    current_row = data[index]
    next_row = data[index + 1]
    name_index = header[:name]
    appears_before(table_body, current_row[name_index], next_row[name_index])
  end
end

=begin
Then I should see 10 apps starting with app 1 with sequence format:
    | name  | description     |
    | app   | app-description |

Will check that the following apps show up in table with id="app_table" in the specified order below
    | name   | description        |
    | app-1  | app-description-1  |
    | app-2  | app-description-2  |
    | app-3  | app-description-3  |
    | app-4  | app-description-4  |
    | app-5  | app-description-5  |
    | app-6  | app-description-6  |
    | app-7  | app-description-7  |
    | app-8  | app-description-8  |
    | app-9  | app-description-9  |
    | app-10 | app-description-10 |
=end
Then /^I should see (\d+) (.+) starting with (?:.+) (\d+) with sequence format:$/ do |count, entity, start, format_table|
  entity = entity.singularize
  table_id = "#{entity}s_table"
  table_element = page.find(:xpath, %{//*[@id="#{table_id}"]/tbody})
  table_element.all(:xpath, 'tr').count.should == count
  raise ArgumentError, 'format table can only have 2 rows' unless format_table.raw.length == 2
  format = format_table.hashes[0]
  sequence = create_sequence(start, format, count)
  last_index = sequence.length - 1
  sequence.each_with_index do |_, index|
    next if index == last_index
    current_item = sequence[index]
    next_item = sequence[index+1]
    current_item.keys.each { |k| appears_before(table_element, current_item[k], next_item[k])}
  end
end
