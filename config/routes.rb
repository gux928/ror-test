Rails.application.routes.draw do

  resources :fixed_assets
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/logout', to:'sessions#destroy'

  resources :users
  root 'welcome#index'

  # get 'rec_docs/:id/print',to: 'rec_docs#print',as: 'print_rec_doc'

  resources :rec_docs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
