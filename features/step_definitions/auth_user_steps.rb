When /^(?:|I )am logged in as "([^"]*)" type$/ do |type|
  case type:
  when "student"
    user = Fred_test
  when "client"

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github,
                          {
                            :uid => '12345',
                            :info => {
                                :name => user_type.name
                                :nickname => user_type.github_uid
                                :email => user_type.email
                                :type_user => user_type
                            }
                          })
end