FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number "4654405418249632"
    result "success"
    created_at "2018-08-13 20:49:53 UTC".to_date
    updated_at "2018-08-13 20:49:53 UTC".to_date
  end
end
