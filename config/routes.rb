Rails.application.routes.draw do
  resource :users, only: [:create] do
    collection do
      post :sign_in
      get :auto_sign_in
    end
  end
end
