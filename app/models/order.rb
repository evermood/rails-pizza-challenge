# frozen_string_literal: true

class Order < ApplicationRecord
  enum state: { open: 'open', completed: 'completed' }
end
