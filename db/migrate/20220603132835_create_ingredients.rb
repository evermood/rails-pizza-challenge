class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :price
      t.integer :price_scale

      t.timestamps
    end
  end
end
