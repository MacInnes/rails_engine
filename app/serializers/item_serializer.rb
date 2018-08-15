class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    '%.2f' % (object.unit_price.to_f / 100)
  end
end
