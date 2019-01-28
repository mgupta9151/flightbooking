class CreateFlightAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_assignments do |t|
      t.references :flight, foreign_key: true
      t.time :arrival_time
      t.date :arrival_date
      t.time :departure_time
      t.date :departure_date
      t.float :base_fare
      t.string :travel_time

      t.timestamps
    end
  end
end
