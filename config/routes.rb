Rails.application.routes.draw do
  resources :applicants, only: [:create, :update, :edit, :show, :new]
  resources :funnels, only: [:index]
  resource :session, only: [:create, :new]
end
