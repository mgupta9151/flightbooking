class CreateFlightSourceDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_source_destinations do |t|
      t.string :name
      t.string :code
      t.string :city

      t.timestamps
    end
  end
end
