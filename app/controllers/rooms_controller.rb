class RoomsController < ApplicationController

	def new
		@stay = Stay.find params[:stay_id]
		@room = Room.new 
	end

	def create
		input = params[:room]

		

		@room = Room.new(
      :stay_id => params[:stay_id],

  		:title => input[:title],
    #   :description => input[:description],

  		# :full_street_address => input[:full_street_address],
  		# :city  => input[:city],
  		# :state  => input[:state],
  		# :country  => input[:country],

  		# :latitude => input[:latitude],
  		# :longitude => input[:longitude],

  		# :wifi => input[:wifi],
  		# :wifi_speed => input[:wifi_speed]
  	)

		@room.save

  	if @room.persisted?
  		# redirect_to :action => 'show', :id => @room.id
  		redirect_to stay_room_path(stay_id: params[:stay_id])
  	else
  		render "new"
  	end
	end	

end
