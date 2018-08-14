FactoryBot.define do
  factory :transaction do
    customer
    merchant 
    status "MyText"
    created_at "2018-08-13 19:12:41"
    updated_at "2018-08-13 19:12:41"
  end
end
