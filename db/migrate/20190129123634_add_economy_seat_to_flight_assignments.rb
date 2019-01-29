class AddEconomySeatToFlightAssignments < ActiveRecord::Migration[5.2]
  def change
  	add_column :flight_assignments, :total_first_seat, :integer,default: 0
    add_column :flight_assignments, :remaining_first_seat, :integer,default: 0
    add_column :flight_assignments, :total_economy_seat, :integer,default: 0
    add_column :flight_assignments, :remaining_economy_seat, :integer,default: 0
    add_column :flight_assignments, :total_business_seat, :integer,default: 0
    add_column :flight_assignments, :remaining_business_seat, :integer,default: 0 
  end
end
