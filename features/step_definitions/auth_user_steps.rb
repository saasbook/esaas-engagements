When /^(?:|I )am logged in as "([^"]*)" type$/ do |type|
  case type
    when "coach"
      user = YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml")["test"] 
    when "student"
      user = YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml")["test_student"]
    when "client"
      user = YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml")["test_client"]
    else 
      raise Exception.new "Illegal user type!"
  end
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github,
                            {
                              :uid => '6789',
                              :info => {
                                  :name => user['name'],
                                  :nickname => user['github_uid'],
                                  :email => user['email'],
                                  # :type_user => user
                              }
                            }
                          )
  visit '/login'
  click_link "Log in with GitHub"
  visit "/apps"
end
