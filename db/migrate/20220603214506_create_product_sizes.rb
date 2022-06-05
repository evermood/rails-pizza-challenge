class CreateProductSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :product_sizes do |t|
      t.string :name
      t.integer :multiplier
      t.integer :multiplier_scale

      t.timestamps
    end
  end
end
