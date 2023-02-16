class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts, id: false do |t|
      t.string :slug, null: false
      t.string :name
      t.decimal :deduction_in_percent, precision: 10, scale: 2, null: false, defaul: 0

      t.timestamps
    end
  end
end
