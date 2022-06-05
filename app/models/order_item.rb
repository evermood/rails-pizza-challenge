class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, class_name: 'Product', foreign_key: 'item_id'
  belongs_to :variant, class_name: 'ProductSize', foreign_key: 'variant_id'
  has_many :order_item_extras
end
