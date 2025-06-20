class DealsSearch
  def initialize(params, limit: 100)
    @params = params
    @limit = limit
  end

  def results
    deals = Deal.includes(:category, :subcategory, :merchant, :locations)

    filter_conditions.each do |clause, value|
      next if value.blank?

      if clause.is_a?(String)
        deals = deals.where(clause, value)
      else
        deals = deals.where(clause => value)
      end
    end

    if @params[:location_id].present?
      deals = deals.joins(:locations).where(locations: { id: @params[:location_id] })
    end

    deals.distinct.limit(@limit)
  end

  private

  def filter_conditions
    {
      "discount_price >= ?" => @params[:min_price],
      "discount_price <= ?" => @params[:max_price],
      category_id: @params[:category_id],
      subcategory_id: @params[:subcategory_id]
    }
  end
end
