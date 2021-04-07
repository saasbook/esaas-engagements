
# NOTICE: 
#When logged in as different type, 
#it's necessary to mention each type this "will" log in as some type
# Otherwise, previous type will store in cache/session? and failed all tests.
Given /^(?:|I )will be logged in as "([^"]*)" type$/ do |type|
  case type.downcase
    when "coach"
      user = YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml")["test"] 
      puts user
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
                                  :type_user => user["staff"]
                              }
                            }
                          )
end
