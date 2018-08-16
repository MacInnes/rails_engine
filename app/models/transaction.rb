class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :success, -> { where(result: 'success')}

  def self.revenue_by_date(date)
    select('SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
      .joins(:invoices, :invoice_items)
      .success
      .where(created_at: date)
  end
end
