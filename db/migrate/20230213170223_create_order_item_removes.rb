class CreateOrderItemRemoves < ActiveRecord::Migration[7.0]
  def change
    create_table :order_item_removes do |t|
      t.references :order_item, null: false, foreign_key: true
      t.string :ingredient

      t.timestamps
    end
  end
end
