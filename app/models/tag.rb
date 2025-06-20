class Tag < ApplicationRecord
  has_many :deals_tags
  has_many :deals, through: :deals_tags
end 