class CreateSavings < ActiveRecord::Migration
  def up
    create_table :savings do |t|
      t.integer :purchase_id
      t.integer :amount_in_pence
      t.string :saving_type

      t.timestamps
    end

  end

  def down
  end
end
