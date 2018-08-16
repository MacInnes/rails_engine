class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(limit = 5)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_total')
    .joins(:transactions, :invoice_items)
    .except(transactions: {result: 'failed' })
    .group('merchants.id')
    .order('merchant_total DESC')
    .limit(limit)
  end

  def self.most_items(limit = 5)
    select('merchants.*, SUM(invoice_items.quantity) AS item_total')
    .joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.success)
    .group(:id)
    .order('item_total DESC')
    .limit(limit)
  end

  # def self.most_items(limit = 5)
  #   select('merchants.*, SUM(invoice_items.quantity) AS item_total')
  #   .joins(:invoice_items, :transactions)
  #   .where(transactions: {result: 'success'})
  #   .group('merchants.id')
  #   .order('item_total DESC')
  #   .limit(limit)
  # end
end
