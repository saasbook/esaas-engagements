# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      then '/'

    when /^the create page$/
      then creation_path

    when /^the Users page$/
      then users_path

    when /^the Orgs page$/
      then orgs_path

    when /^the app details page for "(.*)"$/
      then app_path(App.find_by_name($1))

    when /^the feedback form page for engagement id "(.*)" and iteration id "(.*)"$/ \
      then feedback_form_path(Engagement.find_by_id($1), Iteration.find_by_id($2))

    when /^the engagement iterations page for engagement id "(.*)"$/ \
      then engagement_iterations_path(Engagement.find_by_id($1))

    when /^the edit engagement iteration page for engagement id "(.*)" and iteration id "(.*)"$/ \
      then edit_engagement_iteration_path(Engagement.find_by_id($1), Iteration.find_by_id($2))

    when /^the current iteration page$/ then current_iteration_path

    when /^the new user page$/ then new_user_path

    when /^the edit user page for user id: "(.*)"$/ then edit_user_path($1)

    when /^the edit org page for org id: "(.*)"$/ then edit_org_path($1)

    when /^the new app page$/ then new_app_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
