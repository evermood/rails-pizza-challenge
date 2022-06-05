class Product < ApplicationRecord
  enum group: { pizza: 'pizza', unset: 'unset' }
end
