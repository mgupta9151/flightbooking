class AddSourceDestinationToFlightAssignments < ActiveRecord::Migration[5.2]
  def change
  	add_column :flight_assignments,:source_id,:string
  	add_column :flight_assignments,:destination_id,:string
  end
end
