# == Schema Information
#
# Table name: promotions
#
#  slug       :string           not null, primary key
#  name       :string
#  pizza_slug :string
#  size_slug  :string
#  from       :integer
#  to         :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Model Promotion keeps the promotions that can be applied to an Order
#
class Promotion < ApplicationRecord

  belongs_to :pizza, required: true, foreign_key: :pizza_slug, primary_key: :slug
  belongs_to :pizza_size, required: true, foreign_key: :size_slug, primary_key: :slug

  slug :name
  self.primary_key = :slug

  validates :name, :from, :to, presence: true
  validates :from, :to, numericality: {greater_than: 0}

  scope :ordered, -> { order(:name) }

  # Returns the array of itmes that fit the promotion and the price for them
  def apply_to(items)
    fits = items.that_fit(pizza, pizza_size).to_a
    count = fits.size / from * to
    return [[], 0] if count == 0
    rest = fits.size % from
    [fits[rest..-1].map(&:id), fits.first.base_price * count]
  end
end
