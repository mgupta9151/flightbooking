class Flight < ApplicationRecord
	has_many :flight_seat_configurations, dependent: :destroy
	has_many :flight_seats, dependent: :destroy
	has_many :flight_assignments, dependent: :destroy
	has_many :flight_configuration , through: :flight_seat_configurations
	accepts_nested_attributes_for :flight_seat_configurations
	after_create :create_seats
	extend FriendlyId
  	friendly_id :get_slug, use: :slugged

	def get_slug
	  	self.created_at.to_i.to_s + self.id.to_s
	end

	def create_seats
		first = []
		business = []
		economy = []
		seat_number=1;
		row_number=1
		self.flight_seat_configurations.each do |seat_conf|			
			name = seat_conf.flight_configuration.seat_category.name
			if name== "First Class"
				first << {row: seat_conf.flight_configuration.number_of_row , seat_in_row: seat_conf.flight_configuration.seat_in_row , base_price: seat_conf.flight_configuration.seat_base_price , seat_conf: seat_conf.id}
			elsif name== "Business Class"
			    business << {row: seat_conf.flight_configuration.number_of_row , seat_in_row: seat_conf.flight_configuration.seat_in_row , base_price: seat_conf.flight_configuration.seat_base_price , seat_conf: seat_conf.id}
			elsif name== "Economy Class"
				economy << {row: seat_conf.flight_configuration.number_of_row , seat_in_row: seat_conf.flight_configuration.seat_in_row , base_price: seat_conf.flight_configuration.seat_base_price, seat_conf: seat_conf.id }
			else
			end					
		end	
		if first.present?
			first_row = first[0][:row]
			first_seat_in_row =  first[0][:seat_in_row]
			first_base_price =  first[0][:base_price]
			first_conf =  first[0][:seat_conf]
			
			for i in 1..first_row do
				for j in 1..first_seat_in_row do
					random_token = ""
						loop do
					      random_token = SecureRandom.urlsafe_base64(4, false).upcase
					      break random_token unless FlightSeat.exists?(pnr: random_token)
					    end
					if j ==1 or j == first_seat_in_row
						self.flight_seats.create(flight_seat_configuration_id: first_conf, seat_base_price: first_base_price,row_number: row_number ,seat_number: seat_number,seat_type: "WS",pnr: random_token)
					else
						self.flight_seats.create(flight_seat_configuration_id: first_conf, seat_base_price: first_base_price,row_number: row_number ,seat_number: seat_number,seat_type: "AS",pnr: random_token )
					end
					seat_number+=1
				end
				row_number+=1
			end
		end

		

		if business.present?
			business_row = business[0][:row]
			business_seat_in_row =  business[0][:seat_in_row]
			business_base_price =  business[0][:base_price]
			business_conf =  business[0][:seat_conf]
			for i in 1..business_row do
				for j in 1..business_seat_in_row do
					random_token = ""
						loop do
					      random_token = SecureRandom.urlsafe_base64(4, false).upcase
					      break random_token unless FlightSeat.exists?(pnr: random_token)
					    end

					if j ==1 or j == business_seat_in_row
						self.flight_seats.create(flight_seat_configuration_id: business_conf, seat_base_price: business_base_price,row_number: row_number ,seat_number: seat_number ,seat_type: "WS",pnr: random_token)
					else
						self.flight_seats.create(flight_seat_configuration_id: business_conf, seat_base_price: business_base_price,row_number: row_number ,seat_number: seat_number ,seat_type: "AS" ,pnr: random_token)
					end
					seat_number+=1
				end
				row_number+=1
			end
		end
		
		if economy.present?
			economy_row = economy[0][:row]
			economy_seat_in_row =  economy[0][:seat_in_row]
			economy_base_price =  economy[0][:base_price]
			economy_conf =  economy[0][:seat_conf]
			for i in 1..economy_row do
				for j in 1..economy_seat_in_row do
					random_token = ""
						loop do
					      random_token = SecureRandom.urlsafe_base64(4, false).upcase
					      break random_token unless FlightSeat.exists?(pnr: random_token)
					    end
					if j ==1 or j == economy_seat_in_row
						self.flight_seats.create(flight_seat_configuration_id: economy_conf, seat_base_price: business_base_price,row_number: row_number ,seat_number: seat_number,seat_type: "WS" )
					else
						self.flight_seats.create(flight_seat_configuration_id: economy_conf, seat_base_price: business_base_price,row_number: row_number ,seat_number: seat_number ,seat_type: "AS")
					end
					seat_number+=1
				end
				row_number+=1
			end
		end
	end
end
