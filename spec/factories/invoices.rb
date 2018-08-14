FactoryBot.define do
  factory :invoice do
    merchant
    customer
    status "Shipped"
    created_at "2018-08-13 17:03:43"
    updated_at "2018-08-13 17:03:43"
  end
end
