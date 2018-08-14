class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price
    ActionController::Base.helpers.number_to_currency(object.unit_price)
  end
end
