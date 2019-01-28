class HomeController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => [:index]
  def index
  	@flight_locations = FlightSourceDestination.all
  	@seat_types = SeatCategory.all  	
  end
end
