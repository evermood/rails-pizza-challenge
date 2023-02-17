class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.uuid :order_id, null: false, foreign_key: true
      t.string :pizza_slug, null: false, foreign_key: :slug
      t.string :pizza_size_slug, null: false, foreign_key: :slug

      t.timestamps
    end
  end
end
