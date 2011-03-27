class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :unit_price
      t.integer :quantity
      t.integer :saving

      t.timestamps
    end
  end

  def self.down
    drop_table :purchases
  end
end
