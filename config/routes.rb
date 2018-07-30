Rails.application.routes.draw do
  
  resources :request_attachments
  resources :file_attachments
  get 'costs/populate_options' => 'costs#populate_options'

  get 'costs/get_estimate' => 'costs#get_estimate'

  get "costs/new_dependency" => 'costs#new_dependency', :as => :new_dependency

  get "costs/setfocus" => 'costs#set_focus'

  get "costs/get_dependencies" => 'costs#get_dependencies'

  resources :costs do 
    resources :cost_dependencies
  end

  get 'users/logout'

  get 'requests/preview' => 'requests#preview'

  get 'requests/download' => 'requests#download'

  get 'requests/:id/preview' => 'requests#previewRequestBill'

  patch 'requests/:id/add_other_estimate' => 'requests#add_other_estimate'

  get 'requests/index' => 'requests#index'

  get 'requests/:id/complete' => 'requests#complete'

  resources :requests

  root 'requests#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
