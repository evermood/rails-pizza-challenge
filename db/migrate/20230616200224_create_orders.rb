# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :state, null: false, default: 'open'
      t.jsonb :items
      t.jsonb :promotion_codes
      t.string :discount_code
      t.timestamps
    end
  end
end
