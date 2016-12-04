Rails.application.routes.draw do
  resources :unnovels
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'unnovels#index'
  resources 'unnovels'
end
