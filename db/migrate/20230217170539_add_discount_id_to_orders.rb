class AddDiscountIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :discount_id, :string
    Order.reset_column_information
    reversible do |dir|
      dir.up do
        Order.find_each do |order|
          order.update discount_id: order.discout_ids.first
        end
      end

      dir.down do
        Order.find_each do |order|
          order.update discount_ids: [order.discout_id]
        end
      end
    end
  end
end
