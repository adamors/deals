FactoryBot.define do
  factory :deals_location do
    association :deal
    association :location
    role { 'main' }
  end
end
