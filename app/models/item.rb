class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_revenues(limit = 5)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items, invoices: :transactions)
      .merge(Transaction.success)
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.most_sold(limit = 5)
    select('items.*, SUM(invoice_items.quantity) AS amount_sold')
      .joins(:invoice_items, invoices: :transactions)
      .merge(Transaction.success)
      .group(:id)
      .order('amount_sold DESC')
      .limit(limit)
  end
end
