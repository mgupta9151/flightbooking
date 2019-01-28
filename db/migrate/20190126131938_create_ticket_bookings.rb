class CreateTicketBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_bookings do |t|
      t.references :flight_assignment, foreign_key: true
      t.references :flight_seat, foreign_key: true
      t.references :user, foreign_key: true
      t.float :payble_price

      t.timestamps
    end
  end
end
