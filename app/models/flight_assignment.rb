class FlightAssignment < ApplicationRecord
  belongs_to :flight,optional: true
  belongs_to :source, class_name: "FlightSourceDestination", foreign_key: "source_id"
  belongs_to :destination, class_name: "FlightSourceDestination", foreign_key: "destination_id"
end
