class CreateFlightConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_configurations do |t|
      t.references :seat_category, foreign_key: true
      t.integer :number_of_row
      t.integer :seat_in_row
      t.float :seat_base_price

      t.timestamps
    end
  end
end
