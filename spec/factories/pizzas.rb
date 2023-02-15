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
FactoryBot.define do
  factory :pizza do
    sequence(:name) {|n| "Pizza#{format '%03d', n}" }
    price { rand(0.01..15.99) }
  end
end
