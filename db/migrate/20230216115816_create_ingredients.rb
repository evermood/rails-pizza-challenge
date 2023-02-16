class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients, id: false do |t|
      t.string :slug, null: false
      t.string :name_de
      t.string :name_en
      t.decimal :price, precision: 10, scale: 2, null: false, defaul: 0

      t.timestamps
    end
  end
end
