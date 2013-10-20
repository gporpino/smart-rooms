Smartrooms::Application.routes.draw do

  resources :rooms do
    get '/all/reservations',  to: 'rooms#reservation'
    post '/search' => 'reservations#search'
    resources :reservations do
    end
  end

  resources :users, except: [:index]

  resources :sessions, only: [:new, :create, :destroy]

  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'

  root :to => 'smart_reservations#index', :constraints => lambda{|req| !req.session[:user_id].blank?}, as: :authenticated_root
  root :to => 'static_pages#home'


  get '/smart_reservations/facets',  to: 'smart_reservations#facets'

  get '/smart_reservations/values/:facet', to: 'smart_reservations#values'

  get '/smart_reservations/search', to: 'smart_reservations#search', as: :search
  
end
