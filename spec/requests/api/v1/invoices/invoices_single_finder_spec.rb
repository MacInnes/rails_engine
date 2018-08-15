require 'rails_helper'

describe 'Invoices Single Finder API' do
  context 'GET /api/v1/invoices/find?paramaters' do
    it 'returns an invoice by id' do
      invoice_id = create(:invoice).id

      get "/api/v1/invoices/find?id=#{invoice_id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice['id']).to eq(invoice_id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns an invoice by customer id' do
      invoice_customer_id = create(:invoice).customer_id

      get "/api/v1/invoices/find?customer_id=#{invoice_customer_id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice['customer_id']).to eq(invoice_customer_id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns an invoice by merchant id' do
      invoice_merchant_id = create(:invoice).merchant_id

      get "/api/v1/invoices/find?merchant_id=#{invoice_merchant_id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice['merchant_id']).to eq(invoice_merchant_id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns an invoice by status' do
      invoice_status = create(:invoice).status

      get "/api/v1/invoices/find?status=#{invoice_status}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice['status']).to eq(invoice_status)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns an invoice by created at' do
      invoice_created_at = create(:invoice).created_at

      get "/api/v1/invoices/find?created_at=#{invoice_created_at}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end

    it 'returns an invoice by updated at' do
      invoice_updated_at = create(:invoice).updated_at

      get "/api/v1/invoices/find?updated_at=#{invoice_updated_at}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end
  end

  context 'GET /api/v1/invoices/random' do
    it 'returns a random invoice' do
      create_list(:invoice, 3)

      get '/api/v1/invoices/random'

      invoice =  JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end
  end
end
