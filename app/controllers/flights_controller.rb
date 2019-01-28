class FlightsController < ApplicationController
	def index
		
		from_location = params[:from_location]
		to_location = params[:to_location]
		seat_type = params[:seat_type]
		date = params[:to_date]
		@flights = FlightAssignment.where(arrival_date: date , source_id: from_location, destination_id: to_location)
	end
	def show
		
	end
end
