class PurchasesController < ApplicationController
  respond_to :html, :js
  
  before_filter :find_basket
  
  # def create
  #   product = Product.find_or_create_from_params(params[:product])
  #   
  #   @purchase = product.purchases.build(params[:purchase])
  #   if product.id && @purchase.save
  #     flash[:notice] = "Saved!"
  #     @purchase_created = true
  #   else
  #     flash[:error] = "Invalid!"
  #   end
  #   
  #   respond_to do |format|
  #     format.html { redirect_to @purchase.basket }
  #     format.js { render Basket.find(params[:purchase][:basket_id]) }
  #   end
  # end
  
  def create
    product = Product.find_or_create_from_params(params[:product])
    purchase = @basket.purchases.create_or_update(params[:purchase].merge(:product_id => product.id))
    
    if product.new_record? || purchase.new_record?
      flash[:error] = "'Error saving' - #{product.new_record?}, #{purchase.new_record?}"
    else
      flash[:notice] = 'Saved!'
    end
    
    respond_to do |format|
      format.html { redirect_to @basket }
      format.js { render @basket }
    end
  end
  
  private
  
  def find_basket
    @basket = Basket.find(params[:basket_id])
  end

end
