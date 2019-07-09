Rails.application.routes.draw do  
  get 'feeds', to: 'feeds#feeds'
  get 'feeds/photos', to: 'feeds#feeds_photos'
  get 'feeds/albums', to: 'feeds#feeds_albums'

  get 'discover', to: 'feeds#discover'
  get 'discover/photos', to: 'feeds#discover_photos'
  get 'discover/albums', to: 'feeds#discover_albums'

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
      #update by admin
      put :update_by_admin
      get '/update_by_admin', to: 'users#get_update_by_admin'

    end
    
    resources :photos do 
      member do 
        post :like
      end
    end
    resources :albums do
      member do 
        get :images
        post :like
      end
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

  scope '/admin' do
    get '/', to: 'admin#users', as: :admin_dashboard
    get '/users', to: "admin#users", as: :admin_users
    get '/photos', to: "admin#photos", as: :admin_photos
    get '/albums', to: "admin#albums", as: :admin_albums

    get '/users/:id', to: "users#edit", as: :admin_edit_user
    get '/photos/:id', to: "admin#edit_photo", as: :admin_edit_photo
    put '/photos/:id', to: "admin#update_photo"
    delete '/photos/:id', to: "admin#destroy_photo", as: :admin_delete_photo

    get '/albums/:id', to: "admin#edit_album", as: :admin_edit_album
    put '/albums/:id', to: "admin#update_album"
    delete '/albums/:id', to: "admin#destroy_album", as: :admin_delete_album
    delete '/albums/pics/:id', to: "admin#destroy_pic", as: :admin_delete_pic


  end

  root 'feeds#discover'
  get '*path' => redirect('/404.html')

end
