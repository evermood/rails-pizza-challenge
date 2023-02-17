class RemoveDiscoutIdsFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, "discount_ids", :string, default: [], null: false, array: true
  end
end
