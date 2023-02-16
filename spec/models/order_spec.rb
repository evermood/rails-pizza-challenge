# == Schema Information
#
# Table name: orders
#
#  id            :uuid             not null, primary key
#  state         :string
#  price         :decimal(10, 2)
#  discount_ids  :string           default([]), not null, is an Array
#  promotion_ids :string           default([]), not null, is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

describe Order, type: :model do

  subject(:order) { create :order }

  describe 'validations' do
    it { is_expected.to be_valid }
  end   # validations
end
