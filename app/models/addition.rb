# == Schema Information
#
# Table name: additions
#
#  id            :bigint           not null, primary key
#  order_item_id :bigint           not null
#  ingredient_id :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_additions_on_ingredient_id  (ingredient_id)
#  index_additions_on_order_item_id  (order_item_id)
#

# Model Addition keeps the Ingredients that should be added to a Pizza in an Order
#
class Addition < ApplicationRecord

  belongs_to :order_item, required: true
  belongs_to :ingredient, required: true

  scope :ordered, -> { order(:created_at) }

end
