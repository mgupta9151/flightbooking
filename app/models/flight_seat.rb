class FlightSeat < ApplicationRecord
  belongs_to :flight_seat_configuration
  belongs_to :flight
  has_many :ticket_bookings, dependent: :destroy
  has_one :flight_configuration , through: :flight_seat_configuration  
  has_one :seat_category,through: :flight_configuration 

  def get_seat_status(flight)
  	 if flight.seat_booked_ids.include?(self.id.to_s)
	  	"Booked"
	  else
	  	"Available"
	  end
	end

end
