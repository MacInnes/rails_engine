FactoryBot.define do
  factory :invoice do
    merchant
    customer
    status "MyString"
  end
end
