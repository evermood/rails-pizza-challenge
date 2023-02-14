class OrderItemAdd < ApplicationRecord
  belongs_to :order_item

  validates :order_item, presence: true
  validates :ingredient, presence: true
end
