class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price_to_currency, :merchant_id

  def unit_price_to_currency
    ActionController::Base.helpers.number_to_currency(object.unit_price)
  end
end
