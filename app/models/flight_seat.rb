class FlightSeat < ApplicationRecord
  belongs_to :flight_seat_configuration
  belongs_to :flight
end
