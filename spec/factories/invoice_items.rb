FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity 100
    unit_price 100
  end
end
