class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :pnr
      t.integer :user_id
      t.integer :flight_assignment_id

      t.timestamps
    end
  end
end
