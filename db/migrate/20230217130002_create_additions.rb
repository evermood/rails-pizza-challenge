class CreateAdditions < ActiveRecord::Migration[7.0]
  def change
    create_table :additions do |t|
      t.belongs_to :order_item, null: false, foreign_key: true
      t.belongs_to :ingredient, null: false, type: 'string'

      t.timestamps
    end
  end
end
