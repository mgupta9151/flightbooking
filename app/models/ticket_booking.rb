class TicketBooking < ApplicationRecord
  belongs_to :flight_assignment
  belongs_to :flight_seat
end
