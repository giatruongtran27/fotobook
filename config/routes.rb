Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
  }

  get 'welcome/index'
  get 'feeds/index'

  devise_scope :user do
   get "signup", to: "devise/registrations#new"
   get "login", to: "devise/sessions#new"
   get "logout", to: "devise/sessions#destroy"
   get "forgot-password", to: "devise/passwords#new"

 end
  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  # delete '/logout' => 'sessions#destroy'

  resources :albums do
    resources :pics do
      collection do
      get :list #list_uploads_url
    end
  end
end

  # post 'albums/:album_id(.:format)/album-image' => 'photos#add_image'
  # delete 'albums/:album_id(.:format)/album-image/:id(.:format)' => 'photos#delete_image'

  resources :photos
  resources :users do
  end

  # resources :users

  # ===========================
  # get '/login' => 'sessions#new'
  # get '/signup' => 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'feeds#index'

end
