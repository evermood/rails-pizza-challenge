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
require 'rails_helper'

describe Ingredient, type: :model do

  subject(:ingredient) { create :ingredient }

  describe 'validations' do
    it { is_expected.to be_valid }
    it 'validates presence of :name' do
      ingredient = build :ingredient
      described_class.locale_columns(:name).each do |attr|
        ingredient.send "#{attr}=", ''
      end

      expect(ingredient).not_to be_valid
      expect(ingredient.errors.messages.keys).to eq %i[slug name]
    end
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Ingredient by :slug' do
          expect(Ingredient.ordered).to eq Ingredient.order(:slug)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
