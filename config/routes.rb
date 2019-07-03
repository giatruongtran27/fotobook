Rails.application.routes.draw do
  get 'welcome/index'
  get 'feeds/index'

  get 'users/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
  }
  resources :users do
    resources :photos
    resources :albums do
      resources :pics do
        collection do
          get :list #list_uploads_url
        end
      end
    end
  end
  
  devise_scope :user do
    get "signup", to: "devise/registrations#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
    get "forgot-password", to: "devise/passwords#new"
  end

  # resources :users
 
  # ===========================
  # get '/login' => 'sessions#new'
  # get '/signup' => 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'feeds#index'

end
