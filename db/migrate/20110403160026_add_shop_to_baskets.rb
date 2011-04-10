class AddShopToBaskets < ActiveRecord::Migration
  def self.up
    add_column :baskets, :shop_id, :integer
  end

  def self.down
    remove_column :baskets, :shop_id
  end
end
