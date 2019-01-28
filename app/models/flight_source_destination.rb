class FlightSourceDestination < ApplicationRecord
	validates :name,:code, uniqueness: true
end
