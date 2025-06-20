require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe DealsSearch do
  include ActiveSupport::Testing::TimeHelpers

  around do |example|
    travel_to(Time.zone.local(2025, 6, 20, 12, 0, 0)) { example.run }
  end

  subject(:results) { described_class.new(params).results }

  let!(:category) { create(:category) }
  let!(:subcategory) { create(:subcategory, category: category) }
  let!(:merchant_high) { create(:merchant, rating: 5.0) }
  let!(:merchant_low) { create(:merchant, rating: 2.0) }
  let!(:deal_high_discount) { create(:deal, discount_percentage: 80, merchant: merchant_low, category: category, subcategory: subcategory, quantity_sold: 10) }
  let!(:deal_high_rating) { create(:deal, discount_percentage: 10, merchant: merchant_high, category: category, subcategory: subcategory, quantity_sold: 10) }
  let!(:deal_popular) { create(:deal, discount_percentage: 10, merchant: merchant_low, category: category, subcategory: subcategory, quantity_sold: 1000) }
  let!(:location) { create(:location, lat: 37.7749, lng: -122.4194) }
  let!(:deals_location1) { create(:deals_location, deal: deal_high_discount, location: location, role: 'main') }
  let!(:deals_location2) { create(:deals_location, deal: deal_high_rating, location: location, role: 'main') }
  let!(:deals_location3) { create(:deals_location, deal: deal_popular, location: location, role: 'main') }

  context "without user location" do
    let(:params) { {} }

    it 'ranks deals by discount, rating, and popularity' do
      expect(results.first).to eq(deal_high_discount) # 80*2 + 2*5 + 10*0.1 = 171
      expect(results.second).to eq(deal_popular)      # 10*2 + 2*5 + 1000*0.1 = 130
      expect(results.third).to eq(deal_high_rating)   # 10*2 + 5*5 + 10*0.1 = 46
    end
  end

  context "with user location" do
    let(:params) { { user_lat: 37.7749, user_lng: -122.4194 } } # San Francisco
    let(:far_location) { create(:location, lat: 0, lng: 0) }
    let(:far_deal) do
      create(:deal, discount_percentage: 100, merchant: merchant_high, category: category, subcategory: subcategory, quantity_sold: 10)
    end

    before do
      create(:deals_location, deal: far_deal, location: far_location, role: 'main')
    end

    it 'applies distance penalty if user location is provided' do
      expect(results.first).to eq(deal_high_discount)
      expect(results.map(&:id)).to include(far_deal.id)
    end
  end

  context "when filtering by category/subcategory" do
    let(:params) { { category_id: category.id, subcategory_id: subcategory.id } }
    let(:other_category) { create(:category) }
    let(:other_subcategory) { create(:subcategory, category: other_category) }
    let(:other_deal) { create(:deal, category: other_category, subcategory: other_subcategory, merchant: merchant_low) }

    it 'returns results' do
      expect(results).to include(deal_high_discount, deal_high_rating, deal_popular)
      expect(results).not_to include(other_deal)
    end
  end

  context "when filtering by location" do
    let(:params) { { location_id: location.id } }
    let(:other_location) { create(:location) }
    let(:other_deal) { create(:deal, category: category, subcategory: subcategory, merchant: merchant_low)  }

    before do
      create(:deals_location, deal: other_deal, location: other_location, role: 'main')
    end

    it 'returns results' do
      expect(results).to include(deal_high_discount, deal_high_rating, deal_popular)
      expect(results).not_to include(other_deal)
    end
  end
end
