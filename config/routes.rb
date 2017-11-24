Rails.application.routes.draw do
  # mount ImageUploader::UploadEndpoint => "/images/upload"
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions", :passwords => "users/passwords", :confirmations => "users/confirmations" }

  get '/users/profile', to: 'users#profile', as: 'user_profile'
  put '/users/profile', to: 'users#update_profile', as: 'user_update_profile'

  get '/users/advertisers', to: 'users#advertisers', as: 'user_advertisers'
  put '/users/advertisers', to: 'users#update_advertisers', as: 'user_update_advertisers'
  
  get '/users/brands', to: 'users#brands', as: 'user_brands'
  put '/users/brands', to: 'users#update_brands', as: 'user_update_brands'
  
  get '/users/products', to: 'users#products', as: 'user_products'
  put '/users/products', to: 'users#update_products', as: 'user_update_products'

  get '/users/flagged', to: 'users#flagged', as: 'user_flagged'
  put '/users/flagged', to: 'users#update_flagged', as: 'user_update_flagged'

  get '/users/forum_posts', to: 'users#forum_posts', as: 'user_forum_posts'
  
  get '/users/banners', to: 'users#banners', as: 'user_banners'
  post '/users/banners', to: 'users#update_banners', as: 'user_update_banners'

  get '/users/categories', to: 'users#categories', as: 'user_categories'
  put '/users/categories', to: 'users#update_categories', as: 'user_update_categories'
  post '/users/categories', to: 'users#create_categories', as: 'user_create_categories'

  get '/users/forum_categories', to: 'users#forum_categories', as: 'user_forum_categories'
  put '/users/forum_categories', to: 'users#update_forum_categories', as: 'user_update_forum_categories'
  post '/users/forum_categories', to: 'users#create_forum_categories', as: 'user_create_forum_categories'
  
  resources :forum_threads, :path => 'discussions' do #url = community
    resources :forum_posts, module: :forum_threads
  end

  resources :markets, :path => 'marketplace' #url = marketplace

  resources :brands, param: :name do
    resource :favorite, module: :brands
    resource :like, module: :brands
  end
 
  resources :products do
    resource :like, module: :products
  end
  
  get '', to: 'products#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  post '/products/flag', to: 'products#flag', as: 'product_flag'
  post '/products/vote', to: 'products#vote', as: 'product_vote'

  resources :users do
    collection do
      post :import
    end
  end

  root to: "brands#index"
end
