class DealLocation < ApplicationRecord
  belongs_to :deal
  belongs_to :location
end
