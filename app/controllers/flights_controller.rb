class FlightsController < ApplicationController
	before_action :authenticate_user!,only: [:update_seat,:see_map_and_update_seat,:add_passenger_book_ticke,:add_passenger]
	before_action :find_flight_schedule,only: [:update_seat,:see_map_and_update_seat,:add_passenger,:add_passenger_book_ticket]
	def index		
		from_location = params[:from_location]
		to_location = params[:to_location]
		@seat_type = params[:seat_type]
		@seat_category = SeatCategory.friendly_id.find_by(slug: @seat_type)
		date = params[:to_date]
		@flights = FlightAssignment.joins(:flight_configurations).where(arrival_date: date , source_id: from_location, destination_id: to_location).where('flight_configurations.seat_category_id=?',@seat_category).uniq
	end
	def see_map_and_update_seat
		seat_type = params[:seat_type]
		@passenger = Passenger.find_by(id: params[:psgr])
		@amount = @passenger.ticket_booking.payble_price
		@payble_amount = (@amount * 10)/100
		@seat_category = SeatCategory.friendly.find(params[:seat_type])
		@seat_id = params[:st]
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
		@seat_category = SeatCategory.friendly.find(params[:seat_type])
		@booking = @flight.bookings.new
		1.times {@booking.passengers.build} 
	end

	def update_seat
		@passenger = Passenger.find_by(id: params[:passenger])
		if @flight.seat_booked_ids.include?(params[:changable]).present?
			flash[:error]= "Seat was booked by another one, please tryanother one"
			redirect_to root_path
		else
			@flight.seat_booked_ids -= [params[:prev_seat]]
			@flight.seat_booked_ids << params[:changable]
			@passenger.booking.net_payble += params[:pay_amount].to_f
			@passenger.ticket_booking.payble_price += params[:pay_amount].to_f
			@passenger.ticket_booking.flight_seat_id=params[:changable]
			@flight.save
			@passenger.booking.save
			@passenger.ticket_booking.save
			flash[:success]= "Seat has been updated successfully"
			redirect_to bookings_path
		end
	end
	def add_passenger_book_ticket
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
			
			random_token = ""
			loop do
		      random_token = SecureRandom.urlsafe_base64(4, false).upcase
		      break random_token unless Booking.exists?(pnr: random_token)
		    end
		    params[:booking][:user_id] = current_user.id
			params[:booking][:seat_category_id] = seat_category.id
			params[:booking][:pnr] = random_token

			if @flight.bookings.create(params_booking)
				if first == true
					@flight.remaining_first_seat -=total_passengers
				end
				if business == true
					@flight.remaining_business_seat -=total_passengers
				end
				if economy == true
					@flight.remaining_economy_seat	-=total_passengers
				end
				total = 0
				passengers = current_user.bookings.last.passengers.last(total_passengers)
				seats = @flight.get_available_seats(seat_category.id).first(total_passengers)
				
				passengers.each_with_index do |passenger,i|
					total +=seats[i].seat_base_price
					@flight.ticket_bookings.create(flight_seat_id: seats[i].id,payble_price: seats[i].seat_base_price,passenger_id: passenger.id)
					@flight.seat_booked_ids << seats[i].id
				end
				current_user.bookings.last.update(net_payble: total)
				@flight.save
				flash[:success] = "Booking successfully confirmed your pnr no is= #{current_user.bookings.last.pnr}"
				redirect_to root_path
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
		params.require(:booking).permit(:seat_category_id,:user_id,:flight_assignment_id,:pnr,passengers_attributes:[:id,:name,:id_proof,:age,:booking_id])		
	end
end
