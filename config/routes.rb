OPortfolioWebsite::Application.routes.draw do
  
  get '/entries' => "entries#index"
  
  root :to => 'ember#index'
end
