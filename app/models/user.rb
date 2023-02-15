# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Model User keeps all the users of the project
#
class User < ApplicationRecord

  scope :ordered, -> { order(:name) }

end
