class Invoice < ApplicationRecord
  belongs_to :customer_id
  belongs_to :merchant_id
end
