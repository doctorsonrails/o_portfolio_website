OPortfolioWebsite::Application.routes.draw do
  
  get "session" => "session#new", as: :new_session
  post "login" => "session#login", as: :login
  post "register" => "session#register", as: :register
  
  resources :entries
  root :to => 'entries#index'
  
end
