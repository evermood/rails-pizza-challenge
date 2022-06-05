class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :name
      t.string :code
      t.references :product, null: true, foreign_key: false
      t.references :product_size, null: true, foreign_key: false
      t.string :group
      t.integer :from
      t.integer :to
      t.integer :value
      t.integer :value_scale

      t.timestamps
    end

    add_index :deals, :code, unique: true
  end
end
