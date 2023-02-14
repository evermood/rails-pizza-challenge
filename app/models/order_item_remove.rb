class OrderItemRemove < ApplicationRecord
  belongs_to :order_item

  validates :ingredient, presence: true
end
