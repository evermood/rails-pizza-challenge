class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.uuid :order_id
      t.references :item, null: false, foreign_key: false
      t.string :item_name
      t.references :variant, null: false, foreign_key: false
      t.string :variant_name
      t.integer :price
      t.integer :price_scale
      t.integer :multiplier
      t.integer :multiplier_scale

      t.timestamps
    end

    add_index :order_items, :order_id
  end
end
