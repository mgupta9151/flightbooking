class AddSlugToFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :slug, :string
    add_index :flights, :slug, unique: true

    add_column :flight_assignments, :slug, :string
    add_index :flight_assignments, :slug, unique: true
      
  end
end
