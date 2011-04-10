class BasketsController < ApplicationController
  def index
    @baskets = Basket.all
  end

  def new
    @basket = Basket.new
  end
  
  def create
    @basket = Basket.new(params[:basket])
    if @basket.save
      redirect_to @basket
    else
      render 'new'
    end
  end

  def show
    @basket = Basket.find(params[:id])
  end

end
