class CreateOrderPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :order_promotion_codes do |t|
      t.references :order, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
