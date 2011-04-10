class PurchasesController < ApplicationController
  respond_to :html, :js
  
  def create
    product = Product.find_or_create_from_params(params[:product])
    
    @purchase = product.purchases.build(params[:purchase])
    if product.id && @purchase.save
      flash[:notice] = "Saved!"
    else
      flash[:error] = "Invalid!"
    end
    
    respond_to do |format|
      format.html { redirect_to @purchase.basket }
      format.js { render Basket.find(params[:purchase][:basket_id]) }
    end
  end

end
