class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    "%.2f" % (object.total_revenue.to_f / 100)
  end
end
