require 'rails_helper'

describe 'Invoices Multi Finder API' do
  context 'GET /api/v1/invoices/find_all?parameters' do
    it 'returns all invoices by id' do
      id = 12

      create(:invoice, id: id)

      get "/api/v1/invoices/find_all?id=#{id}"

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(response).to be_successful
      expect(invoices.count).to eq(1)
      expect(invoice['id']).to eq(id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns all invoices by customer id' do
      valid_customer_id = create(:customer).id
      invalid_customer_id = create(:customer).id
      create_list(:invoice, 3, customer_id: valid_customer_id)
      create_list(:invoice, 3, customer_id: invalid_customer_id)

      get "/api/v1/invoices/find_all?customer_id=#{valid_customer_id}"

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
      expect(invoice['customer_id']).to eq(valid_customer_id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns all invoices by merchant id' do
      valid_merchant_id = create(:merchant).id
      invalid_merchant_id = create(:merchant).id
      create_list(:invoice, 3, merchant_id: valid_merchant_id)
      create_list(:invoice, 3, merchant_id: invalid_merchant_id)

      get "/api/v1/invoices/find_all?merchant_id=#{valid_merchant_id}"

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
      expect(invoice['merchant_id']).to eq(valid_merchant_id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns all invoices by status' do
      valid_status = 'shipped'
      invalid_status = 'pending'
      create_list(:invoice, 3, status: valid_status)
      create_list(:invoice, 3, status: invalid_status)

      get "/api/v1/invoices/find_all?status=#{valid_status}"

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
      expect(invoice['status']).to eq(valid_status)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    # it 'returns all invoices by created at' do
    #   id = 12
    #   invoice_created_at = create_list(:invoice, 3, id: 12)
    #
    #   get "/api/v1/invoices/find_all?created_at=#{invoice_created_at}"
    #
    #   invoice = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(invoice).to have_key('customer_id')
    #   expect(invoice).to have_key('merchant_id')
    #   expect(invoice).to have_key('status')
    # end
    #
    # it 'returns all invoices by updated at' do
    #   invoice_updated_at = create_list(:invoice, 3, id:).updated_at
    #
    #   get "/api/v1/invoices/find_all?updated_at=#{invoice_updated_at}"
    #
    #   invoice = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(invoice).to have_key('customer_id')
    #   expect(invoice).to have_key('merchant_id')
    #   expect(invoice).to have_key('status')
    # end
  end
end
