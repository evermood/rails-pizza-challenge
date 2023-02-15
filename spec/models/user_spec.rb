# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

describe User, type: :model do

  subject(:user) { create :user }

  describe 'validations' do
    it { is_expected.to be_valid }
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of User by :name' do
          expect(User.ordered).to eq User.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
