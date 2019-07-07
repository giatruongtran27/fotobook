Rails.application.routes.draw do  
  get 'feeds', to: 'feeds#feeds'
  get 'discover', to: 'feeds#discover'

  get 'users/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    :registrations => 'users/registrations'
  }
  resources :users do
    member do 
      post 'follow/:user_follow_id', to: 'users#edit_add_follow'
      #get followers for followings_tab
      get 'followings', to: 'user#get_followers'
      #get followees for followers_tab
      get 'followees', to: 'user#get_followees'
    end
    
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

  root 'feeds#discover'
  get '*path' => redirect('/404.html')

end
