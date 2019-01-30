class AddPassengerIdInTicketBookings < ActiveRecord::Migration[5.2]
  def change
  	add_column :ticket_bookings, :passenger_id, :integer
  end
end
