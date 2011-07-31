module ProductsHelper
  def ean_for(product)
    if product.ean.blank?
      'x xxxxxx xxxxxx'
    else
      ean = product.ean.to_s
      sprintf('%s %s %s', ean[0,1], ean[1,6], ean[7,6])
    end
  end
  
  def autocomplete_data_for(products)
    [].tap do |array|
      products.each do |product|
        array << { 'product' => { :name => product.name, :ean => ean_for(product) }}
      end
    end
  end
end
