Rails.application.routes.draw do

  resources :templates, only: %i[ new create ]
  resources :emails, only: %i[ new index create show ]
  root "emails#index"
end
