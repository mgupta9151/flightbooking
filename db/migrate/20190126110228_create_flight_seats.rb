class CreateFlightSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_seats do |t|
      t.references :flight_seat_configuration, foreign_key: true
      t.references :flight, foreign_key: true
      t.string :pnr
      t.float :seat_base_price
      t.integer :row_number
      t.integer :seat_number
      t.string :seat_type

      t.timestamps
    end
  end
end
