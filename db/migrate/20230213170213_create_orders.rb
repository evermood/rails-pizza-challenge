class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :state
      t.string :discount_code

      t.timestamps
    end
  end
end
