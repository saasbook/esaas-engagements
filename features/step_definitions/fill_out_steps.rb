When /^I fill in the "(.*)" fields as follows:$/ do |fieldset, table|
  table.hashes.each do |t|
    case t[:value]
    when /^select date "(.*)"$/
      steps %Q{When I select "#{$1}" as the "#{t[:field]}" date}
    when /^select "(.*)"$/
      steps %Q{When I select "#{$1}" from "#{t[:field]}"}
    when /^(un)?checked$/
      steps %Q{When I #{$1}check "#{t[:field]}"}
    when /^choose "(.*)"$/
      steps %Q{When I choose "#{$1}" for "#{t[:field]}"}
    when /^select "(.*)"$/
      steps %Q{When I select "#{$1}" for "#{t[:field]}"}
    else
      if "#{t[:field]}" == "User Type"
        steps %Q{I fill in the following:
         | User Type      | "#{t[:field]}"  |
        }
      else
        steps %Q{When I fill in "#{t[:field]}" with "#{t[:value]}"}
      end
    end
  end
end

Then /^the "(.*)" fields should be filled as follows:$/ do |fieldset, table|
  table.hashes.each do |t|
      steps %Q{Then the field "#{t[:field]}" should be filled with "#{t[:value]}"}
  end
end

