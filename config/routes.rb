Rails.application.routes.draw do

  get 'rec_docs/:id/print',to: 'rec_docs#print',as: 'print'

  resources :rec_docs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
