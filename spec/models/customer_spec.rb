require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end

  describe 'Relationships' do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
  end

  describe 'Instance Methods' do
    it '#favorite_merchant' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      customer = create(:customer)

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)

      invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
      invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id)

      create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
      create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, result: 'failed', invoice_id: invoice_3.id)

      expect(customer.favorite_merchant).to eq(merchant_1)
    end
  end
end
