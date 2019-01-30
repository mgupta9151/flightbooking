class AddNetPaybleToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :net_payble, :float,default: 0
    add_column :bookings, :seat_category_id, :integer
  end
end
