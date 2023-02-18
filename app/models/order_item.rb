# == Schema Information
#
# Table name: order_items
#
#  id              :bigint           not null, primary key
#  order_id        :uuid             not null
#  pizza_slug      :string           not null
#  pizza_size_slug :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# Model OrderItem keeps the elements of an Order
#
class OrderItem < ApplicationRecord

  belongs_to :order, required: true
  belongs_to :pizza, required: true, foreign_key: :pizza_slug, primary_key: :slug
  belongs_to :pizza_size, required: true, foreign_key: :pizza_size_slug, primary_key: :slug
  has_many :additions
  has_many :exemptions

  scope :ordered, -> { order(:created_at) }
  scope :that_fit, ->(pizza, size) do
    where pizza: pizza, pizza_size: size
  end

  def base_price
    pizza.price * pizza_size.coefficient
  end

  def extra_price
    additions.map(&:ingredient).map(&:price).sum * pizza_size.coefficient
  end

end
