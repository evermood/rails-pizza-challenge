class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :state
      t.decimal :price, precision: 10, scale: 2
      t.string :discount_ids, default: [], null: false, array: true
      t.string :promotion_ids, default: [], null: false, array: true

      t.timestamps
    end
  end
end
