class Booking < ApplicationRecord
	belongs_to :flight_assignment
	belongs_to :user
	has_many :passengers , dependent: :destroy
	accepts_nested_attributes_for :passengers
end
