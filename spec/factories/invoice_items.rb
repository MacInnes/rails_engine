FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1
  end
end
