class FlightAssignment < ApplicationRecord
  extend FriendlyId
  friendly_id :get_slug, use: :slugged
  belongs_to :flight,optional: true
  belongs_to :source, class_name: "FlightSourceDestination", foreign_key: "source_id"
  belongs_to :destination, class_name: "FlightSourceDestination", foreign_key: "destination_id"

  def get_slug
  	self.created_at.to_i.to_s + self.id.to_s
   end
end
