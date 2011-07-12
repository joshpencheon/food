class AddDefaultSavingToPurchase < ActiveRecord::Migration
  def self.up
    change_column_default :purchases, :saving, 0
  end

  def self.down
    change_column_default :purchases, :saving, nil
  end
end