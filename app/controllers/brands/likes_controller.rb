class Brands::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_brand

  def create
    @brand.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @brand }
      format.js
    end
  end

  def destroy
    @brand.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to @brand }
      format.js
    end
  end

  private

  def set_brand
    @brand = Brand.find(params[:brand_id])
  rescue
    flash[:alert] = "Brand could not be found."
    redirect_to root_path
  end
end