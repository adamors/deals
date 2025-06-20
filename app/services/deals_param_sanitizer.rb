class DealsParamSanitizer
  class InvalidPrice < StandardError; end

  def initialize(params:)
    @params = params.compact
    @sanitized_params = params
    @errors = []
  end

  def valid?
    sanitize_params!
    check_price!
    true
  rescue StandardError => e
    @errors << e.message
    false
  end

  def params = @sanitized_params
  attr_reader :errors

  private

  def sanitize_params!
    @sanitized_params[:min_price] = Float(@params[:min_price]) if @params[:min_price]
    @sanitized_params[:max_price] = Float(@params[:max_price]) if @params[:max_price]
    @sanitized_params[:user_lat] = Float(@params[:user_lat]) if @params[:user_lat]
    @sanitized_params[:user_lng] = Float(@params[:user_lng]) if @params[:user_lng]
    if @params[:category]
      @sanitized_params[:category_id] = Category.find_by!(name: @params[:category].strip)
    end
    if @params[:subcategory]
      @sanitized_params[:category_id] = Subcategory.find_by!(name: @params[:subcategory].strip)
    end
  end

  def check_price!
    if @params[:min_price] && @params[:max_price] && @params[:min_price] > @params[:max_price]
      raise InvalidPrice, "Min price cannot be greater than max price"
    end
  end
end
