class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions, id: false do |t|
      t.string :slug, null: false
      t.string :name
      t.string :pizza_slug
      t.string :size_slug
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
