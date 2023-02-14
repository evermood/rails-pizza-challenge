module Enums::Order
  extend ActiveSupport::Concern

  included do
    enum state: %i[OPEN COMPLETE], _prefix: true
  end
end
