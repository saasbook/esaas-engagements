FactoryBot.define do
  factory :app do
    name {'app'}
    description {'Application'}
    org
    repository_url { "http://repo.com"}
  end
end
