Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      get '/invoice_items/:invoice_item_id/invoice', to: 'invoice_item_invoice#show'
      get '/invoice_items/:invoice_item_id/item', to: 'invoice_item_item#show'
    end
  end
end
