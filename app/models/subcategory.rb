class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :deals
end
