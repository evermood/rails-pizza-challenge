class Order < ApplicationRecord
  enum state: { open: 'open', completed: 'completed', canceled: 'canceled' }
  has_many :order_items
end
