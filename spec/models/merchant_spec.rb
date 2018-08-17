require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end

  describe 'Relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'Class Methods' do
    it '.most_revenue' do
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

      expect(Merchant.most_revenue(2)).to eq([merchant_1, merchant_2])
    end

    it '.most_items' do
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

      expect(Merchant.most_items(2)).to eq([merchant_1, merchant_2])
    end

    it '.revenue_by_date' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      customer = create(:customer)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)

      bad_date = "2017-08-13".to_date

      invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
      invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id, created_at: bad_date)

      create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
      create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, result: 'failed', invoice_id: invoice_3.id)

      expect(Merchant.revenue_by_date('2017-08-13').total_revenue).to eq(10000)
    end
  end

  describe 'Instance Methods' do
    it '#favorite_customer' do
      merchant = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)

      bad_date = "2017-08-13".to_date

      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
      invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
      invoice_3 = create(:invoice, customer_id: customer_3.id, merchant_id: merchant.id, created_at: bad_date)

      create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
      create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, result: 'failed', invoice_id: invoice_3.id)

      expect(merchant.favorite_customer).to eq(customer_1)
    end

    it '#revenue' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice.id)

      expect(merchant.revenue.total_revenue).to eq(50000)
    end

    it '#revenue_by_date' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      customer = create(:customer)

      bad_date = "2017-08-13".to_date

      invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: bad_date)
      create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)

      expect(merchant.revenue_by_date('2017-08-13').total_revenue).to eq(30000)
    end

    it '#customers_with_pending_invoices' do
      merchant = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)

      bad_date = "2017-08-13".to_date

      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
      invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
      invoice_3 = create(:invoice, customer_id: customer_3.id, merchant_id: merchant.id, created_at: bad_date)

      create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
      create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

      create(:transaction, invoice_id: invoice_1.id, result: 'failed')
      create(:transaction, invoice_id: invoice_2.id, result: 'failed')
      create(:transaction, invoice_id: invoice_3.id)

      expect(merchant.customers_with_pending_invoices).to eq([customer_1, customer_2])
    end
  end
end
