FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity 100
    unit_price 100
    created_at "2018-08-13 17:03:43"
    updated_at "2018-08-13 17:03:43"
  end
end
