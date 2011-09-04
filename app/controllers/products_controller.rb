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
      format.json { render :json => view_context.autocomplete_data_for(@products) }
    end
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    
    if @product.save
      redirect_to products_path
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
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to products_path
    else
      flash[:error] = "Failed to delete product"
    end
  end

end
