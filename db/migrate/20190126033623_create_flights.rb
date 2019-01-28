class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :name
      t.string :code     

      t.timestamps
    end
    add_index :flights, :name, unique: true
    add_index :flights, :code, unique: true
  end
end
