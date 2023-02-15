class CreatePizzas < ActiveRecord::Migration[7.0]
  def change
    create_table :pizzas, id: false do |t|
      t.string :slug, null: false
      t.string :name
      t.decimal :price, precision: 10, scale: 2, null: false, defaul: 0

      t.timestamps
      t.index :slug, unique: true
    end
  end
end
