FactoryBot.define do
  factory :subcategory do
    name { "Sushi" }
    association :category
  end
end
