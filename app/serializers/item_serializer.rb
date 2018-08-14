class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    (object.unit_price.to_f / 100).round(2).to_s
  end
end
