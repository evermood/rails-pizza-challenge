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
  has_many :items, dependent: :destroy, class_name: 'OrderItem'

  scope :open, -> { where(state: 'open') }
  scope :ordered, -> { order(:created_at) }

  def complete!
    update state: 'done', price: current_price
  end

  def current_price
    price = base_price + extra_price
    discount.blank? ? price : discount.apply_to(price)
  end

  def base_price
    price = 0.to_d
    fits = promotions.each_with_object([]) do |promotion, ids|
      pr_ids, pr_price = promotion.apply_to items
        logger.debug {%Q<Order@#{__LINE__}#base_price: #{promotion.inspect} #{pr_ids.inspect} #{pr_price}>}
      ids << pr_ids
      price += pr_price
    end.flatten
      logger.debug {%Q<Order@#{__LINE__}#base_price: #{fits.inspect} #{price} #{items}>}
    price + items.where.not(id: fits).map(&:base_price).sum
  end

  def extra_price
    items.map(&:extra_price).sum
  end

  def total_price
    price || current_price
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
