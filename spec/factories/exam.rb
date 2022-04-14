FactoryBot.define do
  factory :exam do
    name { 'Complect' }
    starts_on { Time.current + 1.day }
    ends_on { Time.current + 2.days }
    user 
    updated_by { user }
  end
end