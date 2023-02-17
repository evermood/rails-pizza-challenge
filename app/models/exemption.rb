# == Schema Information
#
# Table name: exemptions
#
#  id            :bigint           not null, primary key
#  order_item_id :bigint           not null
#  ingredient_id :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_exemptions_on_ingredient_id  (ingredient_id)
#  index_exemptions_on_order_item_id  (order_item_id)
#

# Model Exemption keeps the Ingredients that should not be added to a Pizza in an Order
#
class Exemption < ApplicationRecord

  belongs_to :order_item, required: true
  belongs_to :ingredient, required: true

  scope :ordered, -> { order(:created_at) }

end
