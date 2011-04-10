class ProductsController < ApplicationController
  respond_to :html, :json
    
  def index
    @products = if params[:query].blank?
      Product.includes(:purchases).all
    else
      Product.limit(10).find_for_autocomplete(params[:query])
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => @products }
    end
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
    @product = Product.find(params[:id])
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end

end
