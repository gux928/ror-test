Rails.application.routes.draw do

  root 'welcome#index'

  # get 'rec_docs/:id/print',to: 'rec_docs#print',as: 'print_rec_doc'

  resources :rec_docs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
