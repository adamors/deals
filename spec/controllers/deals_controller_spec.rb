require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  let!(:category) { create(:category) }
  let!(:subcategory) { create(:subcategory, category: category) }
  let!(:merchant) { create(:merchant) }
  let!(:deal) { create(:deal, category: category, subcategory: subcategory, merchant: merchant) }
  let!(:location) { create(:location) }
  let!(:deals_location) { create(:deals_location, deal: deal, location: location, role: 'main') }

  describe 'GET #index' do
    it 'returns all deals by default' do
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first['id']).to eq(deal.id)
    end

    it 'filters by min_price' do
      get :index, params: { min_price: 50 }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ 'message' => 'No deals found matching your criteria.' })
    end

    it 'filters by max_price' do
      get :index, params: { max_price: 40 }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ 'message' => 'No deals found matching your criteria.' })
    end

    it 'filters by category_id' do
      get :index, params: { category_id: category.id }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first['id']).to eq(deal.id)
    end

    it 'filters by location_id' do
      get :index, params: { location_id: location.id }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first['id']).to eq(deal.id)
    end

    it 'returns error for invalid price range' do
      get :index, params: { min_price: 100, max_price: 10 }, format: :json
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to match(/Min price cannot be greater than max price/)
    end

    it 'returns error for invalid category' do
      get :index, params: { category: 'Nonexistent' }, format: :json
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to be_present
    end
  end
end
