class UsersController < ApplicationController
  # helper_method :current_market
  before_action :authenticate_user!, :set_user
  helper_method :set_market


  # load_and_authorize_resource
  # def index
  #   @users = User.all
  #   @import = User::Import.new

  #   respond_to do |format|
  #     format.html
  #     format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
  #   end
  # end

  # def import
  #   @import = User::Import.new user_import_params
  #   if @import.save
  #     redirect_to users_path, notice: "Imported #{@import.imported_count} users"
  #   else
  #     @users = User.all
  #     flash[:alert] = "There were #{@import.errors.count} errors with your CSV file"
  #     render action: :index
  #   end
  # end

  
  # def become
  #   return unless current_user.admin?
  #   sign_in(:user, User.find(params[:id]))
  #   redirect_to root_url # or user_root_url
  # end
  def index
    @users = User.all
  end

  def profile
    @user = current_user
  end

  def advertisers
    if current_user.admin?
      @users = User.all
    else 
      redirect_to root_path
    end
  end

  def update_advertisers
    if current_user.admin?
      @user = User.find(params[:format])
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      if @user.update(advertiser_params)
        flash[:notice] = "Successfully updated User."
        redirect_to user_advertisers_path
      else
        flash[:alert] = @user.errors.full_messages
        redirect_to user_advertisers_path
      end
    else 
      redirect_to root_path
    end
  end

  def flagged
    if current_user.admin? || current_user.is_mod?
      @flags = Flag.all.order("created_at DESC")
    else 
      redirect_to root_path
    end
  end

  def update_flagged
    set_product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to :user_flagged, notice: 'Flagged product was successfully deleted.'}
        format.json { render :user_flagged, status: :ok, location: :user_flagged }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def products
    if current_user.admin?
      @products = Product.all.where(market: @market).order("created_at DESC")
    else 
      @products = current_user.products.where(market: @market).order("created_at DESC")
    end
  end

  def update
    set_product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to :user_products, notice: 'Product was successfully deleted.'}
        format.json { render :user_products, status: :ok, location: :user_products }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def brands
    @user = current_user
    if current_user.brand.present?
      @brand = current_user.brand
    else
      @brand = Brand.new
    end
  end

  def update_brands
    set_brand
    respond_to do |format|
      if @brand.update(brand_params)
        @brand.save
        format.html { redirect_to :user_brands, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: :user_brands }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def banners 
    if current_user.admin?
      @banner = Banner.new
    else 
      redirect_to root_path
    end
  end

  def update_banners
    set_banner
    if current_user.admin?
      respond_to do |format|
        if @banner.update(banner_params)
          format.html { redirect_to :user_banners, notice: 'Banner was successfully updated.' }
          format.json { render :user_banners, status: :ok, location: :user_banners }
        else
          format.html { render :edit }
          format.json { render json: @banner.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to root_path
    end
  end

  def categories 
    # set_category
    if current_user.admin?
      @categories = Category.all.where(market_id: @market).order("created_at DESC")
      @category = Category.new
    else 
      redirect_to root_path
    end
  end

  def create_categories
    if current_user.admin?
      @category = Category.create(category_params)
      @category.market_id = @market.id

      if @category.save
        redirect_to user_categories_path
      else
        render action: :new
      end
    end
  end

  def update_categories
    set_category
    if current_user.admin?
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to :user_categories, notice: 'Category was successfully updated.' }
          format.json { render :user_categories, status: :ok, location: :user_categories }
        else
          byebug
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to root_path
    end
  end

  def forum_categories 
    # set_forum_category
    if current_user.admin?
      @forum_categories = ForumCategory.all.where(market_id: @market).order("created_at DESC")
      @forum_category = ForumCategory.new
    else 
      redirect_to root_path
    end
  end

  def create_forum_categories
    if current_user.admin?
      @forum_category = ForumCategory.create(forum_category_params)
      @forum_category.market_id = @market.id

      if @forum_category.save
        redirect_to user_forum_categories_path
      else
        render action: :new
      end
    end
  end

  def update_forum_categories
    set_forum_category
    if current_user.admin?
      respond_to do |format|
        if @forum_category.update(forum_category_params)
          format.html { redirect_to :user_forum_categories, notice: 'Category was successfully updated.' }
          format.json { render :user_forum_categories, status: :ok, location: :user_forum_categories }
        else
          byebug
          format.html { render :edit }
          format.json { render json: @forum_category.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to root_path
    end
  end


  def forum_posts 
    @forum_posts = current_user.forum_posts
  end



  def messages

  end

  private
    def set_user
      @user = current_user.id
    end 

    def set_users
      @users = User.all
    end

    def set_product
      @product = Product.find_by!(id: params[:product][:id], market: @market)
    rescue
      flash[:alert] = "Product could not be found"
      redirect_to root_path
    end

    def set_banner
      @banner = Banner.where(user_id: @user, market: @market).first_or_create
    end

    def set_brand
      @brand = Brand.where(user_id: @user).first_or_create
    end

    def set_category
      @category = Category.find_by!(market_id: @market)
    end

    def set_forum_category
      @forum_category = ForumCategory.find_by!(market_id: @market)
    end
    
    def user_import_params
      params.require(:user_import).permit(:file)
    end
    
    def advertiser_params
      params.require(:user).permit(:is_advertiser)
    end

    def product_params
      params.require(:product).permit(:user_id, :title, :description, :price, :market_id, :category_id, :expire_date)
    end

    def banner_params
      params.require(:banner).permit(:user_id, :market_id, :product_index, :product_show, :product_new, :forum_index, :forum_show, :forum_new, :account_profile)
    end

    def brand_params
      params.require(:brand).permit(:name, :phone_number, :website, :email, :facebook, :twitter, :instagram, :logo)
    end

    def category_params
      params.require(:category).permit(:market_id, :category_name, :group_id)
    end

    def forum_category_params
      params.require(:forum_category).permit(:market_id, :category_name, :group_id)
    end
end
