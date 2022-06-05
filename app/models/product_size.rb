class ProductSize < ApplicationRecord
  def multiplier_percentage
    (multiplier / (10**multiplier_scale).to_f).round(multiplier_scale)
  end
end
