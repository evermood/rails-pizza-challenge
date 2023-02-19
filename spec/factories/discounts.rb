# == Schema Information
#
# Table name: discounts
#
#  slug                 :string           not null, primary key
#  name                 :string
#  deduction_in_percent :decimal(10, 2)   not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
FactoryBot.define do
  factory :discount do
    sequence(:name) {|n| "DiscountName#{format '%03d', n}" }
    deduction_in_percent { rand 1.1..5.99 }
  end
end
