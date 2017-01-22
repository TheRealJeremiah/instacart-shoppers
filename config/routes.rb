Rails.application.routes.draw do
  resources :applicants, only: [:create, :update, :edit, :show, :new]
  resources :funnels, only: [:index]
end
