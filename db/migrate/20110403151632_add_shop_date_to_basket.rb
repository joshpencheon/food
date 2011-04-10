class AddShopDateToBasket < ActiveRecord::Migration
  def self.up
    add_column :baskets, :shop_date, :datetime
  end

  def self.down
    remove_column :baskets, :shop_date
  end
end
