FactoryBot.define do
  factory :deal do
    title { '50% Off Premium Sushi Dinner for Two' }
    description { 'Enjoy an authentic Japanese sushi experience.' }
    original_price { 89.99 }
    discount_price { 44.99 }
    discount_percentage { 50 }
    association :category
    association :subcategory
    association :merchant
    quantity_sold { 100 }
    expiry_date { '2025-07-15' }
    featured_deal { true }
    image_url { 'https://example.com/sushi-dinner.jpg' }
    fine_print { 'Valid Monday-Thursday.' }
    review_count { 10 }
    average_rating { 4.5 }
    available_quantity { 50 }
  end
end
