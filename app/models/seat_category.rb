class SeatCategory < ApplicationRecord
	has_many :flight_configurations
end
