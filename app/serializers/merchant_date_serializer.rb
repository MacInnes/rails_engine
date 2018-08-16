class MerchantDateSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    "%.2f" % (object.total_revenue.to_f / 100)
  end
end
