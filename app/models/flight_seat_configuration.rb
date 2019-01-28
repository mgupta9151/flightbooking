class FlightSeatConfiguration < ApplicationRecord
  belongs_to :flight
  belongs_to :flight_configuration
end
