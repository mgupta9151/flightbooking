class FlightAssignment < ApplicationRecord
  extend FriendlyId
  friendly_id :get_slug, use: :slugged
  belongs_to :flight,optional: true
  belongs_to :source, class_name: "FlightSourceDestination", foreign_key: "source_id"
  belongs_to :destination, class_name: "FlightSourceDestination", foreign_key: "destination_id"
  has_many :flight_configurations , through: :flight
  has_many :flight_seats , through: :flight
  has_many :bookings, dependent: :destroy
  has_many :ticket_bookings, dependent: :destroy

  before_save :set_duration
  def get_slug		 
	  DateTime.current.to_i.to_s + Random.rand(10000).to_s
	end

  def set_duration
    day_in_minutes = TimeDifference.between(self.arrival_date, self.departure_date).in_minutes
    time_in_minutes = TimeDifference.between(self.arrival_time, self.departure_time).in_minutes
    total_in_minutes = day_in_minutes + time_in_minutes
    self.travel_time = total_in_minutes
         self.flight.flight_configuration.each do |flight_conf|
           if flight_conf.seat_category.name == "First Class"            
            first_seats = FlightConfiguration.where(seat_category_id: flight_conf.seat_category).first
            seats = first_seats.number_of_row.to_i * first_seats.seat_in_row.to_i
            self.total_first_seat = seats
            self.remaining_first_seat = seats
           elsif flight_conf.seat_category.name == "Economy Class"
            first_seats = FlightConfiguration.where(seat_category_id: flight_conf.seat_category).first
            seats = first_seats.number_of_row.to_i * first_seats.seat_in_row.to_i
            self.total_economy_seat = seats
            self.remaining_economy_seat = seats
           elsif flight_conf.seat_category.name == "Business Class"
            first_seats = FlightConfiguration.where(seat_category_id: flight_conf.seat_category).first
            seats = first_seats.number_of_row.to_i * first_seats.seat_in_row.to_i
            self.total_business_seat = seats
            self.remaining_business_seat = seats
           end
         end        
  end
end
