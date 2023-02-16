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
require 'rails_helper'

describe PizzaSize, type: :model do

  subject(:pizza_size) { create :pizza_size }

  describe 'validations' do
    it { is_expected.to be_valid }
    it 'validates presence of :name' do
      pizza_size = build :pizza_size
      described_class.locale_columns(:name).each do |attr|
        pizza_size.send "#{attr}=", ''
      end

      expect(pizza_size).not_to be_valid
      expect(pizza_size.errors.messages.keys).to eq %i[slug name]
    end
    it { is_expected.to validate_presence_of :coefficient}
    it { is_expected.to validate_numericality_of(:coefficient).is_greater_than 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of PizzaSize by :slug' do
          expect(PizzaSize.ordered).to eq PizzaSize.order(:slug)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
