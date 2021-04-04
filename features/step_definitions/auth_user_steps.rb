When /^(?:|I )am logged in as "([^"]*)"$/ do |user|
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github,
                          {
                            :uid => '12345',
                            :info => {
                                :name => user['name'],
                                :nickname => user['github_uid'],
                                :email => user['email'],
                                :type_user => user['staff']
                            }
                          })
end