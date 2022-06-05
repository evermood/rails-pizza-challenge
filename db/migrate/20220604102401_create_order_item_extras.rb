class CreateOrderItemExtras < ActiveRecord::Migration[7.0]
  def change
    create_table :order_item_extras do |t|
      t.references :order_item, null: false, foreign_key: true
      t.references :extra, null: false, foreign_key: false
      t.string :group
      t.string :name
      t.integer :price
      t.integer :price_scale

      t.timestamps
    end
  end
end
