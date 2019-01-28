class CreateFlightSeatConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_seat_configurations do |t|
      t.references :flight, foreign_key: true
      t.references :flight_configuration, foreign_key: true

      t.timestamps
    end
  end
end
