class Deal < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
  belongs_to :subcategory

  has_many :deals_locations
  has_many :locations, through: :deals_locations
  has_many :deals_tags
  has_many :tags, through: :deals_tags

  has_one :main_deals_location, -> { where(role: "main") }, class_name: "DealsLocation"
  has_one :main_location, through: :main_deals_location, source: :location

  has_many :redemption_deals_locations, -> { where(role: "redemption") }, class_name: "DealsLocation"
  has_many :redemption_locations, through: :redemption_deals_locations, source: :location

  def self.serializable_fields
    {
      only: [ :id, :title, :description, :discount_price, :original_price, :expiry_date, :featured_deal, :image_url ],
      include: {
        category: { only: [ :id, :name ] },
        merchant: { only: [ :id, :name, :rating ] },
        locations: { only: [ :id, :address, :city, :state, :zip_code ] }
      }
    }
  end
end
