class DealsController < ApplicationController
  rescue_from Exception do |exception|
    Rails.logger.error("Exception found: #{exception.message}")
    render json: { error: exception.message, stack: exception.backtrace }, status: 500
  end

  def index
    sanitizer = DealsParamSanitizer.new(params: deal_search_params)

    unless sanitizer.valid?
      return render json: { error: sanitizer.errors.join(", ") }, status: :bad_request
    end

    deals = DealsSearch.new(sanitizer.params).results

    if deals.empty?
      render json: { message: "No deals found matching your criteria." }, status: :ok
    else
      render json: deals.as_json(Deal.serializable_fields), status: :ok
    end
  end

  private

  def deal_search_params
    params.permit(:min_price, :max_price, :category, :subcategory, :location)
  end
end
