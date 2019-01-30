ActiveAdmin.register FlightAssignment, as: "Flight Schedule" do
	before_action :only => [:show,:edit,:update,:destroy] do		
    @flight_schedule = FlightAssignment.friendly.find_by(slug: params[:id])
  end

	 menu priority: 6
	 permit_params :flight_id,:arrival_time, :arrival_date,:departure_time,:departure_date,:base_fare,:travel_time,:source_id,:destination_id
	index do
		column :flight_id
		column :source
		column :destination
		column :arrival_time
		column :arrival_date
		column :departure_time
		column :departure_date
		column :base_fare
		column :travel_time

		actions
	end

	filter :flight

	form do |f|
		f.inputs do
			f.input :flight
			f.input :source
			f.input :destination
			f.input :arrival_date,as: :datepicker
			f.input :departure_date,as: :datepicker
			f.input :arrival_time	,as: :time_picker		
			f.input :departure_time	,as: :time_picker	
			
		end
		f.actions
	end

	show do |flight_sch|
		attributes_table do
			row :flight_id
			row :source_id
			row :destination_id
			row :arrival_date
			row :arrival_time
			row :departure_date
			row :departure_time
			row :travel_time			
		end
		tabs do
			tab 'Flight Seat Details' do
					render partial: 'admin/flight/seat_details', locals: {:seats => flight_sch.flight_seats,flight: flight_sch}
			end

		end
	end

end
