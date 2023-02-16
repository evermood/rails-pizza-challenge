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
FactoryBot.define do
  factory :pizza_size do
    sequence(:name_de) {|n| "Name de#{format '%03d', n}" }
    sequence(:name_en) {|n| "Name en#{format '%03d', n}" }
    coefficient { rand(0.8..1.99) }
  end
end
