class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :basket_id
      t.float :proportion

      t.timestamps
    end
  end
end
