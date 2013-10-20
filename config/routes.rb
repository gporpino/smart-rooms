Smartrooms::Application.routes.draw do

  resources :rooms do
    resources :reservations
  end

  resources :users, except: [:index]

  resources :sessions, only: [:new, :create, :destroy]

  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/reservations/:id',  to: 'rooms#reservation'

  root :to => 'rooms#index', :constraints => lambda{|req| !req.session[:user_id].blank?}, as: :authenticated_root
  root :to => 'static_pages#home'

end
