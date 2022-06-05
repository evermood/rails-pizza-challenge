class Deal < ApplicationRecord
  enum group: { promo: 'promo', percent: 'percent', absolute: 'absolute' }
  belongs_to :product
  belongs_to :product_size
end
