Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#index'

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get 'users/index', :to => 'users#index', :as => 'user_index'
  post 'users/subscribe', :to => 'users#subscribe', :as => 'user_subscribe'
  post 'users/unsubscribe', :to => 'users#unsubscribe', :as => 'user_unsubscribe'

end
