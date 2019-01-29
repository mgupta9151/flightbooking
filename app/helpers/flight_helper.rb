module FlightHelper
	def check_availability(flight_assignment,flight_seat)
	  	already = flight_seat.ticket_bookings.where(flight_assignment_id: flight_assignment.id)
	  	# already = TicketBooking.where(flight_assignment_id: flight_assignment.id,flight_seat_id: self.id)
	  	if already.present?
	  		return "Not Available"
	  	else
	  		return "Available"
	  	end
	  end

	  def get_price(seat_type)
	  	FlightSeat.joins(:flight_configuration).where('flight_configurations.seat_category_id=?',1).first.seat_base_price
	  end
	  def get_duration(travel_time)
	  	hours = travel_time / 60
	    in_minutes = travel_time % 60
	    return "#{hours.to_i}:#{in_minutes.to_i} HOUR"
	  end

end
