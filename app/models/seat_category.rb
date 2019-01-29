class SeatCategory < ApplicationRecord
	has_many :flight_configurations
	extend FriendlyId
  	friendly_id :get_slug, use: :slugged

	def get_slug
	  	self.created_at.to_i.to_s + self.id.to_s
	end
end
