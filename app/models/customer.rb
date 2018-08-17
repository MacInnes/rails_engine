class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :created_at, :updated_at

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.select('merchants.*, COUNT(merchants.id) AS merchant_count')
      .group(:id)
      .order('merchant_count DESC')
      .limit(1)
      .take
  end
end
