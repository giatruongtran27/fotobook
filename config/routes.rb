Rails.application.routes.draw do
  get 'welcome/index'

  get 'feeds/index'

  get '/login' => 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'feeds#index'

end
