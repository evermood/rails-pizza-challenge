# == Schema Information
#
# Table name: exemptions
#
#  id            :bigint           not null, primary key
#  order_item_id :bigint           not null
#  ingredient_id :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_exemptions_on_ingredient_id  (ingredient_id)
#  index_exemptions_on_order_item_id  (order_item_id)
#
require 'rails_helper'

describe Exemption, type: :model do

  subject(:exemption) { create :exemption }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to :order_item}
    it { is_expected.to belong_to :ingredient}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Exemption by #created_at' do
          expect(Exemption.ordered).to eq Exemption.order(:created_at)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
