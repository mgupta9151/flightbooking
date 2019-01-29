ActiveAdmin.register Flight do
	before_action :only => [:show,:edit,:update,:destroy] do
    @flight = Flight.friendly.find_by(slug: params[:id])
  end

	 menu priority: 5
	permit_params :name, :code,flight_seat_configurations_attributes:[:id,:flight_id,:flight_configuration_id]

	index do		
		column :name
		column :code

		actions
	end

	filter :name
	filter :code	
	filter :created_at

	form do |f|
		f.inputs do
			f.input :name
			f.input :code
			f.has_many :flight_seat_configurations,
			allow_destroy: true,
			new_record: true do |a|
				a.input :flight_configuration
			end
		end
		f.actions
	end

	show do |flight|
		attributes_table do
			row :name
			row :code
		end
		tabs do
			tab 'Flight Seat' do
					render partial: 'admin/flight/seats', locals: {:seats => flight.flight_seats}
			end

		end
	end

	controller do
    def scoped_collection
      Flight.all.includes(:flight_seats).order('created_at desc')
    end

    def show
    	@flight = Flight.includes(flight_seats:[:flight_seat_configuration=>[:flight_configuration=> [:seat_category]] ]).friendly.find_by(slug: params[:id])
    end
end

end

