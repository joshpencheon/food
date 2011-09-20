class ShopsController < ApplicationController
  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(params[:shop])
    if @shop.save
      flash[:notice] = "'#{@shop.name}' created."
      redirect_to root_url
    else
      flash[:error] = "Invalid shop"
      render :action => 'new'
    end
  end

end
