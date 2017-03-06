Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :styles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'

  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'

  resources :ratings, only: [:index, :new, :create, :destroy]

  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only:[:index, :show]
  post 'places', to: 'places#search'

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'toggle_ban', on: :member
  end
  
  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'

  resources :memberships do
    post 'confirm', on: :member
  end

  get 'auth/:provider/callback', to: 'sessions#create_oauth'
end
