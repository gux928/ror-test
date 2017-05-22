Rails.application.routes.draw do

  resources :photos
  resources :fixed_assets
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/logout', to:'sessions#destroy'

  get '/upload', to:'welcome#upload' ,as:'upload_csv'
  post '/upload', to:'welcome#import_csv'
  post '/upload_new', to:'welcome#import_csv_new'
  post '/upload_db', to:'welcome#import_db'

  get '/download_doc', to:'welcome#download_doc',as: 'download_doc'
  get '/download_fa', to:'welcome#download_fa',as: 'download_fa'
  get '/download_db', to:'welcome#download_db',as: 'download_db'


  get '/fixed_assets/:id/upload',to:'fixed_assets#upload',as: 'upload_fixed_assets'
  post '/fixed_assets/:id/upload',to:'fixed_assets#save_pic'

  get '/test_func',to:'welcome#test_func'

  resources :users
  root 'welcome#index'

  # get 'rec_docs/:id/print',to: 'rec_docs#print',as: 'print_rec_doc'

  resources :rec_docs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
