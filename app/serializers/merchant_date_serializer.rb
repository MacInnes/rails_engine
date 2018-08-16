class MerchantDateSerializer < ActiveModel::Serializer
  attributes :total_revenue
  def total_revenue
    "%.2f" % (object.total_revenue / 100)
  end

end
