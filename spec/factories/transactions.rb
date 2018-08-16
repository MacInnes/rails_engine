FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number ""
    credit_card_expiration_date "MyText"
    result "success"
    created_at "2018-08-13 20:49:53 UTC"
    updated_at "2018-08-13 20:49:53 UTC"
  end
end
