class Passenger < ApplicationRecord
	belongs_to :booking
	has_one :ticket_booking
end
