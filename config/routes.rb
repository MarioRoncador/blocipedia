Rails.application.routes.draw do

  resources :wikis

  resources :charges, only: [:new, :create]

  devise_for :users


    resources :users do
      member do
        post :downgrade
      end
    end


  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

end
