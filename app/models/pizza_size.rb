# == Schema Information
#
# Table name: pizza_sizes
#
#  slug        :string           not null, primary key
#  name_de     :string
#  name_en     :string
#  coefficient :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Model PizzaSize keeps the available sizes of Pizzas with price coefficient
#
class PizzaSize < ApplicationRecord

  slug :name_en
  self.primary_key = :slug

  translates :name, fallback: :any

  validates :name, :coefficient, presence: true
  validates :coefficient, numericality: {greater_than: 0}

  scope :ordered, -> { order(:slug) }

end
