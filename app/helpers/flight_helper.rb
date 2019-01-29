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
end
