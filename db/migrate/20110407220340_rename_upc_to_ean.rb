class RenameUpcToEan < ActiveRecord::Migration
  def self.up
    rename_column :products, :upc, :ean
  end

  def self.down
    rename_column :products, :ean, :upc
  end
end