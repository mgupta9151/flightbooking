ActiveAdmin.register FlightConfiguration do
	menu priority: 4
	permit_params :seat_category_id,:number_of_row,:seat_in_row,:seat_base_price

	index do
		column :seat_category
		column :number_of_row
		column :seat_in_row

		actions
	end

	filter :seat_category
	filter :number_of_row	

	form do |f|
		f.inputs do
			f.input :seat_category
			f.input :number_of_row
			f.input :seat_in_row
			f.input :seat_base_price
		end
		f.actions
	end
end
