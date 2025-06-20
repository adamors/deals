class DealsSearch
  def initialize(params, limit: 100)
    @params = params
    @limit = limit
  end

  def results
      Deal.from("(#{scored.to_sql}) AS deals")
        .select("*")
        .order("score DESC")
        .limit(@limit)
  end

  private

  def base
    Deal
      .includes(:category, :subcategory, :merchant, :locations)
      .joins(:merchant)
      .yield_self do |relation|
        if @params[:location_id].present?
          relation = relation.joins(:locations).where(locations: { id: @params[:location_id] })
        end

        filter_conditions.each do |clause, value|
          next if value.blank?

          relation = clause.is_a?(String) ? relation.where(clause, value) : relation.where(clause => value)
        end
        relation
      end
  end

  def distance_sql
    return "0" unless @params[:user_lat].present? && @params[:user_lng].present?
     # Haversine distance
     <<~SQL.squish
     6371 * 2 * ASIN(SQRT(
       POWER(SIN((#{@params[:user_lat]} - locations.lat) * PI() / 180 / 2), 2) +
         COS(#{@params[:user_lat]} * PI() / 180) * COS(locations.lat * PI() / 180) *
         POWER(SIN((#{@params[:user_lng]} - locations.lng) * PI() / 180 / 2), 2)
     ))
     SQL
  end

  def scored
    # See alg.md
    base
      .select("deals.*", "merchants.rating", "#{distance_sql} AS distance_km")
      .select(<<~SQL.squish)
    (
      COALESCE(deals.discount_percentage, 0) * 2 +
      COALESCE(merchants.rating, 0) * 5 +
      COALESCE(deals.quantity_sold, 0) * 0.1 -
      COALESCE(#{distance_sql}, 0)
    ) AS score
      SQL
  end

  def filter_conditions
    {
      "discount_price >= ?" => @params[:min_price],
      "discount_price <= ?" => @params[:max_price],
      category_id: @params[:category_id],
      subcategory_id: @params[:subcategory_id]
    }
  end
end
