Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Figaro.env.github_key!, Figaro.env.github_secret!
  unless Rails.env.production?
    OmniAuth.config.test_mode = true
    user = YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml")
    OmniAuth.config.add_mock(:github, { :uid => '12345',
        :info => {:name => user['name'], :nickname => user['github_uid'],
          :email => user['email'] }})
  end
end
