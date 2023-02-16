# == Schema Information
#
# Table name: promotions
#
#  slug       :string           not null, primary key
#  name       :string
#  pizza_slug :string
#  size_slug  :string
#  from       :integer
#  to         :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

describe Promotion, type: :model do

  subject(:promotion) { create :promotion }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of :name}
    it { is_expected.to validate_presence_of :from}
    it { is_expected.to validate_presence_of :to}
    it { is_expected.to validate_numericality_of(:from).is_greater_than 0}
    it { is_expected.to validate_numericality_of(:to).is_greater_than 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Promotion by :name' do
          expect(Promotion.ordered).to eq Promotion.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
