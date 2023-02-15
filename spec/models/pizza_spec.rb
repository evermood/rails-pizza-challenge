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
require 'rails_helper'

describe Pizza, type: :model do

  subject(:pizza) { create :pizza }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of :name}
    it { is_expected.to validate_presence_of :price}
    it { is_expected.to validate_numericality_of(:price).is_greater_than 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Pizza by :name' do
          expect(Pizza.ordered).to eq Pizza.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
