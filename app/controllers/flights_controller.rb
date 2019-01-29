class FlightsController < ApplicationController
	def index		
		from_location = params[:from_location]
		to_location = params[:to_location]
		@seat_type = params[:seat_type]
		date = params[:to_date]
		@flights = FlightAssignment.where(arrival_date: date , source_id: from_location, destination_id: to_location)
	end
	def book_ticket
		@seat_type = params[:seat_type]
		seat_category = SeatCategory.friendly_id.find_by(@seat_type)
		@flight = FlightAssignment.friendly_id.find_by(params[:id])
		if seat_category.present? && @flight.present?
			flight_configuration = @flight.flight.flight_configuration.find_by(seat_category: seat_category)
			@flight_seats = @flight.flight.flight_seats.includes(:ticket_bookings).joins(:flight_configuration).where('flight_configurations.seat_category_id=?',seat_category)

			@seat = flight_configuration.seat_in_row
			@row = flight_configuration.number_of_row			
		else
			redirect_to root_path,:flash => { :error => "Please select again" }
		end	
	end
end
