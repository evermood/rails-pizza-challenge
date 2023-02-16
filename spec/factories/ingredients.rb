# == Schema Information
#
# Table name: ingredients
#
#  slug       :string           not null, primary key
#  name_de    :string
#  name_en    :string
#  price      :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :ingredient do
    sequence(:name_de) {|n| "IngredientName de#{format '%03d', n}" }
    sequence(:name_en) {|n| "IngredientName en#{format '%03d', n}" }
    price { rand(0.8..1.99) }
  end
end
