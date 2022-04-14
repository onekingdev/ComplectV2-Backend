FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user_#{n}_#{rand(1000).to_s}@factory.com" }
    password { '123456789' }
    confirmed_at { Time.current }
  end
end