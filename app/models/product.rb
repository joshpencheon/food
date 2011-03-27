class Product < ActiveRecord::Base
  attr_accessible :name, :upc
  
  validates_presence_of :name
end
