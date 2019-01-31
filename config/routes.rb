Rails.application.routes.draw do
	root 'home#index'

	devise_for :users
	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	resources :flights do
		member do
			get :add_passenger
			post :add_passenger_book_ticket
			get :see_map_and_update_seat
			get :update_seat
		end
		collection do
			get :get_pnr_detail
			get :ticket_list
		end
	end

	resources :bookings , only:[:index,:show] do
	end
end
