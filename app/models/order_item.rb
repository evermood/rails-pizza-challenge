class OrderItem < ApplicationRecord
  belongs_to :order
  has_many :order_item_adds, dependent: :destroy
  has_many :order_item_removes, dependent: :destroy

  validates :order, presence: true
  validates :name, presence: true
  validates :size, presence: true
end
