FactoryBot.define do
  factory :location do
    address { '123 Sushi Way' }
    city { 'San Francisco' }
    state { 'CA' }
    zip_code { '94103' }
    lat { 37.7749 }
    lng { -122.4194 }
  end
end
