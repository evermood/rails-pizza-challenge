# == Schema Information
#
# Table name: ingredients
#
#  slug       :string           not null
#  name_de    :string
#  name_en    :string
#  price      :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Model Ingredient keeps the ingredients that can be added or removed from a pizza
#
class Ingredient < ApplicationRecord

  slug :name_en
  self.primary_key = :slug

  translates :name, fallback: :any

  validates :name, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}

  scope :ordered, -> { order(:slug) }

end
