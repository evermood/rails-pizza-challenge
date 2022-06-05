class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :state
      t.string :promotions, array: true, default: []
      t.string :discount

      t.timestamps
    end
  end
end
