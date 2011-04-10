class AddBasketIdToPurchase < ActiveRecord::Migration
  def self.up
    add_column :purchases, :basket_id, :integer
  end

  def self.down
    remove_column :purchases, :basket_id
  end
end
