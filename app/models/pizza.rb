# == Schema Information
#
# Table name: pizzas
#
#  slug       :string           not null, primary key
#  name       :string
#  price      :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pizzas_on_slug  (slug) UNIQUE
#

# Model Pizza keeps all the kins of Pizzas we sell
#
class Pizza < ApplicationRecord

  slug :name
  self.primary_key = :slug

  validates :name, :price, presence: true
  validates :price, numericality: {greater_than: 0}

  scope :ordered, -> { order(:name) }

end
