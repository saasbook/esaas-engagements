source 'https://rubygems.org'

# Keep Ruby version in Gemfile in sync with Ruby version in Dockerfile
ruby '2.4.5'

gem 'rails', '4.2.11.1'
gem 'omniauth-github'
gem 'select2-rails', '~> 4.0', '>= 4.0.3'
gem 'json'
gem 'figaro'
gem 'haml'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.1'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap_form'
gem 'paperclip', '~> 5.2.1'
gem 'aws-sdk', '~> 2.3.0'

# Code Snippet Added by Course Staff for Logging
gem 'listen', '~> 3.0'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  gem 'sqlite3', "~> 1.3.6"
  gem 'byebug'
  gem 'simplecov', :require => false
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'puma', '>= 4.3.1'
  gem 'guard-rspec'
  gem 'factory_bot_rails', '>= 4.11.1', '< 5.0.0'
  gem 'jasmine-rails'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'launchy'
end

gem 'axe-matchers', group: [:test, :development]

group :production do
  gem 'pg', '< 1.0.0'
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



