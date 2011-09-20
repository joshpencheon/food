class RemoveSavingsFromPurchase < ActiveRecord::Migration
  def up
    remove_column :purchases, :saving_in_pence  
  end

  def down
    add_column :purchases, :saving_in_pence, :integer, :default => 0
  end
end
