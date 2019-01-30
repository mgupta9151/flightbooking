class AddSeatBookedIdInFlightAssignments < ActiveRecord::Migration[5.2]
  def change
  	add_column :flight_assignments, :seat_booked_ids, :text, default: [], array:true
  end
end
