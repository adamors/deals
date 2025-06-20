class Location < ApplicationRecord
  has_many :deals_locations
  has_many :deals, through: :deals_locations
end 