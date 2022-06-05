class OrderItemExtra < ApplicationRecord
  enum group: { add: 'add', remove: 'remove' }
  belongs_to :order_item
  belongs_to :extra, class_name: 'Ingredient', foreign_key: 'extra_id'
end
