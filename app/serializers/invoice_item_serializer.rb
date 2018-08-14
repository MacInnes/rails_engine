class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price
    (object.unit_price.to_f / 100).round(2).to_s
  end
end
