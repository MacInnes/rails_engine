class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.select('merchants.*, COUNT(merchants.id) AS merchant_count')
      .group(:id)
      .order('merchant_count DESC')
      .limit(1)
      .take
  end
end
