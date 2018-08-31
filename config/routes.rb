Rails.application.routes.draw do
  resources :file_resources, except: [:edit, :show, :update] do
    member do
      get :download_file, as: :download
      get :pet_report
      get :product_report_xlsx
    end
  end
  root to: "file_resources#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
