Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do  
      scope module: :invoices do
        resources :invoices, only: [:index, :show] do
          get '/invoice_items', to: 'invoice_invoice_items#index'
          get '/items', to: 'invoice_items_relation#index'
          get '/merchant', to: 'invoice_merchant#show'
        end
      end
      scope module: :items do
        resources :items, only: [:index, :show] do
          get '/merchant', to: 'item_merchant#show'
          get '/invoice_items', to: 'item_invoice_items#index'
        end
      end
      scope module: :invoice_items do
        resources :invoice_items, only: [:index, :show] do
          get '/invoice', to: 'invoice_item_invoice#show'
          get '/item', to: 'invoice_item_item#show'
        end
      end
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
