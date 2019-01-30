class BookingsController < ApplicationController
	before_action :authenticate_user!
	def index
		@bookings = current_user.bookings.includes(:flight_assignment,:passengers)
	end
	def show
		@booking = current_user.bookings.includes(:flight_assignment).find_by(id: params[:id])	
	end
end
