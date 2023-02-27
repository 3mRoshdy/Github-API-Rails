Rails.application.routes.draw do
  root 'repositories#search'

  get '/search', to: 'repositories#search'
end
