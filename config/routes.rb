Rails.application.routes.draw do
	root 'home#index'

	devise_for :users
	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	resources :flights do
		member do
			get :add_passenger
			post :add_passenger_book_ticket
			get :book_ticket
		end
	end
end
