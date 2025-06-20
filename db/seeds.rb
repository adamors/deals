# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

file = File.read(Rails.root.join('data.json'))
data = JSON.parse(file)

data.each do |deal_data|
  merchant = Merchant.find_or_create_by!(
    name: deal_data['merchantName']
  ) do |m|
    m.rating = deal_data['merchantRating']
  end

  category = Category.find_or_create_by!(name: deal_data['category'])

  subcategory = Subcategory.find_or_create_by!(
    name: deal_data['subcategory'],
    category: category
  )

  deal = Deal.create!(
    title: deal_data['title'],
    description: deal_data['description'],
    original_price: deal_data['originalPrice'],
    discount_price: deal_data['discountPrice'],
    discount_percentage: deal_data['discountPercentage'],
    category: category,
    subcategory: subcategory,
    merchant: merchant,
    quantity_sold: deal_data['quantitySold'],
    expiry_date: deal_data['expiryDate'],
    featured_deal: deal_data['featuredDeal'],
    image_url: deal_data['imageUrl'],
    fine_print: deal_data['finePrint'],
    review_count: deal_data['reviewCount'],
    average_rating: deal_data['averageRating'],
    available_quantity: deal_data['availableQuantity']
  )

  main_location = deal_data['location']
  location = Location.find_or_create_by!(
    address: main_location['address'],
    city: main_location['city'],
    state: main_location['state'],
    zip_code: main_location['zipCode'],
    lat: main_location['lat'],
    lng: main_location['lng']
  )
  DealsLocation.create!(deal: deal, location: location, role: 'main')

  (deal_data['redemptionLocations'] || []).each do |loc|
    redemption_location = Location.find_or_create_by!(
      address: loc['address'],
      city: loc['city'],
      state: loc['state'],
      zip_code: loc['zipCode'],
      lat: loc['lat'],
      lng: loc['lng']
    )
    DealsLocation.find_or_create_by!(deal: deal, location: redemption_location, role: 'redemption')
  end

  (deal_data['tags'] || []).each do |tag_name|
    tag = Tag.find_or_create_by!(name: tag_name)
    DealsTag.find_or_create_by!(deal: deal, tag: tag)
  end
end
