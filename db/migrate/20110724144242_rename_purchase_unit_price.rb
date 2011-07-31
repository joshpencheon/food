class RenamePurchaseUnitPrice < ActiveRecord::Migration
  def self.up
    rename_column :purchases, :unit_price, :unit_price_in_pence
    rename_column :purchases, :saving, :saving_in_pence
  end

  def self.down
    rename_column :purchases, :saving_in_pence, :saving
    rename_column :purchases, :unit_price_in_pence, :unit_price
  end
end