class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(limit = 5)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_total')
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
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

  def self.revenue_by_date(date)
    date = date.to_date
    start_date = date.beginning_of_day
    end_date = date.end_of_day
    select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .where('invoices.created_at BETWEEN ? AND ?', start_date, end_date)
      .limit(1)
      .take
  end

  def favorite_customer
    customers.select('customers.*, COUNT(customers.id) AS customer_count')
      .group(:id)
      .order('customer_count DESC')
      .limit(1)
      .take
  end

  def revenue
    invoices.select('SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
      .joins(:transactions, :invoice_items)
      .merge(Transaction.success)
      .limit(1)
      .take
  end


  def customers_with_pending_invoices
    customers.find_by_sql("SELECT customers.* FROM customers
    INNER JOIN invoices ON customers.id = invoices.customer_id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    WHERE invoices.merchant_id = #{id}
    EXCEPT
    SELECT customers.* FROM customers
    INNER JOIN invoices ON customers.id = invoices.customer_id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    WHERE transactions.result = 'success' AND invoices.merchant_id = #{id};")
  end

  def revenue_by_date(date)
    date = date.to_date
    start_date = date.beginning_of_day
    end_date = date.end_of_day
    invoices.select('SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
      .joins(:transactions, :invoice_items)
      .merge(Transaction.success)
      .where('invoices.created_at BETWEEN ? AND ?', start_date, end_date)
      .limit(1)
      .take
  end
end
