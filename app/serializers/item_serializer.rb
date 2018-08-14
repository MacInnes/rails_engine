class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    ActionController::Base.helpers.number_to_currency(object.unit_price)
  end
end
