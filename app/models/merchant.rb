class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(limit = 5)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_total')
    .joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .group('merchants.id')
    .order('merchant_total DESC')
    .limit(limit)
  end

end
