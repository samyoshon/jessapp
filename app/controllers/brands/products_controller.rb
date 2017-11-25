#global
$max_products = 5
$days_posted = 14
$pagination_count = 25


class Brands::ProductsController < ApplicationController
  # before_action :set_market
  before_action :set_product, except: [:index, :new, :create]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]

  def index
    @q = Product.search(params[:q])

    @products = Product.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ? AND (products.expire_date IS null OR products.expire_date > ?)", @market.id, Time.now)

    if params[:q].present?
      @products = @q.result.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ? AND (products.expire_date IS null OR products.expire_date > ?)", @market.id, Time.now)
    end
    @flag = Flag.new
    @user = current_user

    # if params[:location].present?
    #   @products = @products.near(params[:location]).where(market: @market)
    # end

    # @products = @products.paginate(:page => params[:page], :per_page => 30)
  end

  def flag
    @flag = Flag.new(flag_params)
    if @flag.save
      flash[:alert] = "Product has been reported."
      redirect_to root_path
    else
      flash[:alert] = "Could not flag product."
    end
  end

  def show
    @product = Product.find(params[:id])
    @user = current_user
  end

  def new
    @product = Product.new
    @user = current_user
    @products = current_user.products.count
  end

  def edit
    @products = current_user.products.count
  end

  def create
    @product = current_user.products.build(product_params)
    @product.market_id = @market.id
    @product.expire_date = $days_posted.days.from_now

    if @product.save
      redirect_to @product
    else
      render action: :new
    end
  end

  def update
    @product.expire_date = $days_posted.days.from_now
    respond_to do |format|
      if @product.update(product_params)
        @product.save
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_market
    @market = Market.find_by_subdomain!(request.subdomain) unless request.subdomain.empty?
  end

  def set_product
    @product = Product.find_by!(id: params[:id], market: @market)
  rescue
    flash[:alert] = "Product could not be found"
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :market_id, :category_id, :expire_date, {images:[]}, :contact_pref, :contact_by_email, :contact_by_phone, user_attributes: [:phone_number])
  end

  def flag_params
    params.require(:flag).permit(:user_id, :product_id)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :product_id)
  end
end
