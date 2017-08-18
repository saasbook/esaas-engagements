# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "#{Rails.root}/db/orgs.rb"
require "#{Rails.root}/db/apps.rb"
# Create the user used for mocking the GitHub OAuth login in non-production envs.
User.create!(YAML.load(File.read "#{Rails.root}/db/github_mock_login.yml"))

