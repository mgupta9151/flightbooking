class FlightConfiguration < ApplicationRecord
  belongs_to :seat_category,optional: true
  belongs_to :flight,optional: true
  has_many :flight_seat_configurations
  def to_s
  	self.seat_category.name + " Number Of Row: #{self.number_of_row}"+ " Seat in Row: #{self.seat_in_row}"	
  end
end
