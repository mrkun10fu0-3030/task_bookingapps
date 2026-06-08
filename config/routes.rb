Rails.application.routes.draw do
  devise_for :users
  root "home#top"
  get "users/show", to: "users#show", as: "user_show"
  get "users/edit_profile", to: "users#edit_profile", as: "edit_profile"
  patch "users/update_profile", to: "users#update_profile", as: "update_profile"
  get "rooms/search", to: "rooms#search", as: "search_rooms"
  resources :rooms do
    resources :reservations, only: [:new, :create] do
      collection do
        post :confirm
      end
    end
  end
  resources :reservations, only: [:index]
end
