class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :group
      t.integer :price
      t.integer :price_scale

      t.timestamps
    end
  end
end
