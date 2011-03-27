class ProductsController < ApplicationController
  respond_to :html, :json
    
  def index
    @products = Product.all
    respond_with(@products)
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    
    if @product.save
      # TEMP:
      redirect_to products_path(:format => :json)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end

end
