require 'rails_helper'

RSpec.describe DealsParamSanitizer do
  subject(:sanitizer) { described_class.new(params:) }

  let(:category) { create(:category, name: 'Food & Drink') }
  let(:subcategory) { create(:subcategory, name: 'Sushi', category: category) }

  context "when params are valid" do
    let(:params) do
      {
        min_price: '10',
        max_price: '100',
        category: category.name,
        subcategory: subcategory.name
      }
    end

    it 'is valid' do
      expect(sanitizer.valid?).to be true
      expect(sanitizer.errors).to be_empty
      expect(sanitizer.params[:min_price]).to eq(10.0)
      expect(sanitizer.params[:max_price]).to eq(100.0)
      expect(sanitizer.params[:category_id]).to eq(subcategory)
    end
  end

  context "when min price is greater than max price" do
    let(:params) { { min_price: 100, max_price: 10 } }

    it "is not valid" do
      expect(sanitizer.valid?).to be false
      expect(sanitizer.errors.join).to match(/Min price cannot be greater than max price/)
    end
  end

  context "when category doesn't exist" do
    let(:params) { { category: 'Nonexistent' } }

    it "is not valid" do
      expect(sanitizer.valid?).to be false
      expect(sanitizer.errors.join).to match(/Couldn't find Category/)
    end
  end

  context "when subcategory doesn't exist" do
    let(:params) { { subcategory: 'Nonexistent' } }

    it "is not valid" do
      expect(sanitizer.valid?).to be false
      expect(sanitizer.errors.join).to match(/Couldn't find Subcategory/)
    end
  end
end
