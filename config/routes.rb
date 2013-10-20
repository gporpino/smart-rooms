Smartrooms::Application.routes.draw do

  resources :rooms do
    get '/reservations',  to: 'rooms#reservation'
    resources :reservations
  end

  resources :users, except: [:index]

  resources :sessions, only: [:new, :create, :destroy]

  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'

  root :to => 'rooms#index', :constraints => lambda{|req| !req.session[:user_id].blank?}, as: :authenticated_root
  root :to => 'static_pages#home'

end
