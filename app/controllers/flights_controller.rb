class FlightsController < ApplicationController
	before_action :authenticate_user!,only: [:book_ticket]
	before_action :find_flight_schedule,only: [:book_ticket,:add_passenger,:add_passenger_book_ticket]
	def index		
		from_location = params[:from_location]
		to_location = params[:to_location]
		@seat_type = params[:seat_type]
		@seat_category = SeatCategory.friendly_id.find_by(slug: @seat_type)
		date = params[:to_date]
		@flights = FlightAssignment.joins(:flight_configurations).where(arrival_date: date , source_id: from_location, destination_id: to_location).where('flight_configurations.seat_category_id=?',@seat_category).uniq
	end
	def book_ticket
		@seat_type = params[:seat_type]
		@seat_category = SeatCategory.friendly_id.find_by(slug: @seat_type)
		
		if @seat_category.present? && @flight.present?
			flight_configuration = @flight.flight.flight_configuration.find_by(seat_category: @seat_category)
			@flight_seats = @flight.flight_seats.includes(:ticket_bookings).joins(:flight_configuration).where('flight_configurations.seat_category_id=?',@seat_category)

			@seat = flight_configuration.seat_in_row
			@row = flight_configuration.number_of_row			
		else
			redirect_to root_path,:flash => { :error => "Please select again" }
		end	
	end

	def add_passenger
		@booking = @flight.bookings.new
		1.times {@booking.passengers.build} 
	end

	def book_seat
		
	end
	def add_passenger_book_ticket
		binding.pry
		available_seats = 0
		seat_category = SeatCategory.friendly.find(params[:seat_type])
		first = false
		business = false
		economy = false
		if seat_category.name = "First Class"
			available_seats = @flight.remaining_first_seat
			first = true
		elsif seat_category.name = "Business Class"
			available_seats = @flight.remaining_business_seat
			business = true
		elsif seat_category.name = "Economy Class"
			available_seats = @flight.remaining_economy_seat
			economy = true
		else
			available_seats=0
		end
				
		total_passengers = params[:booking][:passengers_attributes].keys.count	
		if total_passengers <= available_seats
			
			if @flight.bookings.create(params_booking)
				if first
					@flight.remaining_first_seat -=total_passengers
				end
				if business
					@flight.remaining_business_seat -=total_passengers
				end
				if economy
					@flight.remaining_economy_seat	-=total_passengers
				end
				binding.pry
				@flight.save
				redirect_to root_path,flash[:success] = "Booking successfully confirmed"
			end
		else
			flash[:error] = "Sorry No seat available for your requested passenger #{total_passengers}"
			redirect_to add_passenger_flight_path(@flight,seat_type:params[:seat_type])
		end
	end

	private
	def find_flight_schedule
		@flight = FlightAssignment.friendly_id.find_by(slug: params[:id])
	end
	def params_booking
		params.require(:booking).permit(:user_id,:flight_assignment_id,:pnr,passengers_attributes:[:id,:name,:id_proof,:age,:booking_id])		
	end
end
