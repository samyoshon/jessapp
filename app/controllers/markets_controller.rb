class MarketsController < ApplicationController
  before_action :set_market, except: [:index, :new, :create]

  def index
    @markets = Market.all
  end

  def show
    @market = Market.find(params[:id])
  end

  def new
    @market = Market.new
    @market.products.new
  end

  def create
    # @market = current_user.markets.new market_params
    @market = current_user.markets.build(market_params)
    @market.user_id = current_user.id
    @market.store_id = '1'

    if @market.save
      redirect_to @market
    else
      render action: :new
    end
  end

  private

  def set_market
    @market = Market.find(params[:id])
  end

  def market_params
    params.require(:market).permit(:user_id, :store_id, :title, :description)
  end

end
