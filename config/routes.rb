Rails.application.routes.draw do
  root to: 'games#index', as: '/'
  get 'index', to: 'games#index', as: :new
  post 'score', to: 'games#score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
