Smartrooms::Application.routes.draw do

  resources :rooms do
    resources :reservations
  end

  resources :users, except: [:index]

  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  root :to => 'rooms#index', :constraints => lambda{|req| !req.session[:user_id].blank?}, as: :authenticated_root
  root :to => 'static_pages#home'

end
