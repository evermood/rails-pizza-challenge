# == Schema Information
#
# Table name: orders
#
#  id            :uuid             not null, primary key
#  state         :string
#  price         :decimal(10, 2)
#  promotion_ids :string           default([]), not null, is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  discount_id   :string
#

# Model Order keeps all the pizza orders
#
class Order < ApplicationRecord
  before_create :set_ready! #FIXME: Install AASM

  belongs_to :discount, optional: true
  has_many :order_items, dependent: :destroy

  def complete!
    update state: 'done'
  end

  def promotions
    promotion_ids.map do |slug|
      Promotion.find slug
    end
  end

  def promotions=(promotions)
    update promotion_ids: promotions.map(&:slug)
  end

  private

  def set_ready!
    self.state ||= "open"
  end
end
