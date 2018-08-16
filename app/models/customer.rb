class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    invoices.select('merchants.*, COUNT(transactions.id) AS transactions_count')
      .joins(:invoice_items, :transactions, :merchant)
      .merge(Transaction.success)
      .group('merchants.id')
      .order('transactions_count DESC')
      .limit(1)
      .take
  end
end
