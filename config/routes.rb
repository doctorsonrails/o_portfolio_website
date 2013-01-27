OPortfolioWebsite::Application.routes.draw do
  
  get "session" => "session#new", as: :new_session
  post "login" => "session#login", as: :login
  get "logout" => "session#logout", as: :logout
  
  resource :user
  resources :entries
  root :to => 'entries#index'
  
end
