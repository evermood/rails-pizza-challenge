class CreatePizzaSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :pizza_sizes, id: false do |t|
      t.string :slug, null: false
      t.string :name_de
      t.string :name_en
      t.decimal :coefficient, precision: 10, scale: 2, null: false, defaul: 1

      t.timestamps
    end
  end
end
