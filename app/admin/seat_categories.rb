ActiveAdmin.register SeatCategory do
	menu priority: 3
	permit_params :name
	actions :index, :show
	index do		
		column :name	

		actions
	end

	filter :name

	form do |f|
		f.inputs do
			f.input :name
			
		end
		f.actions
	end
end
