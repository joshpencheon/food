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
      flash[:error] = "Basket not valid"
      render 'new'
    end
  end

  def update
    @basket = Basket.find(params[:id])
    if @basket.update_attributes(params[:basket])
      redirect_to @basket
    else
      flash[:error] = "Error updating basket"
      render 'show'
    end
  end

  def show
    @basket = Basket.find(params[:id])
  end

end
