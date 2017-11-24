class BrandsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]

  def index
    @q = Brand.search(params[:q])

    # @brands = Brand.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ? AND (brands.expire_date IS null OR brands.expire_date > ?)", @market.id, Time.now)
    @brands = Brand.paginate(page: params[:page], per_page: $pagination_count)

    if params[:q].present?
      # @brands = @q.result.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ? AND (brands.expire_date IS null OR brands.expire_date > ?)", @market.id, Time.now)
      @brands = @q.result.paginate(page: params[:page], per_page: $pagination_count)
    end
    @flag = Flag.new
    @user = current_user

    # if params[:location].present?
    #   @brands = @products.near(params[:location]).where(market: @market)
    # end

    # @products = @products.paginate(:page => params[:page], :per_page => 30)
  end

  def flag
    @flag = Flag.new(flag_params)
    if @flag.save
      flash[:alert] = "Brand has been reported."
      redirect_to root_path
    else
      flash[:alert] = "Could not flag brand."
    end
  end

  def show
    @brand = Brand.find_by(name: params[:name])
    @user = current_user
  end

  private

  def set_market
    @market = Market.find_by_subdomain!(request.subdomain) unless request.subdomain.empty?
  end

  def flag_params
    params.require(:flag).permit(:user_id, :product_id)
  end
end
