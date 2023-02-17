# == Schema Information
#
# Table name: order_items
#
#  id              :bigint           not null, primary key
#  order_id        :uuid             not null
#  pizza_slug      :string           not null
#  pizza_size_slug :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

describe OrderItem, type: :model do

  subject(:order_item) { create :order_item }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to :order}
    it { is_expected.to belong_to :pizza}
    it { is_expected.to belong_to :pizza_size}
    it { is_expected.to have_many :additions}
    it { is_expected.to have_many :exemptions}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of OrderItem by #created_at' do
          expect(OrderItem.ordered).to eq OrderItem.order(:created_at)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
