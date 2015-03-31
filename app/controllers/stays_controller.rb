class StaysController < ApplicationController
	def new
		@stay = Stay.new
	end

	def create
		input = params[:stay]
		@stay = Stay.new(
  		:title => input[:title],

  		:full_street_address => input[:full_street_address],
  		:city  => input[:city],
  		:state  => input[:state],
  		:country  => input[:country],

  		:latitude => input[:latitude],
  		:longitude => input[:longitude],

  		:wifi => input[:wifi],
  		:wifi_speed => input[:wifi_speed]
  	)

		@stay.save

  	if @stay.persisted?
  		redirect_to :action => 'show', :id => @stay.id
  	else
  		render "new"
  	end
	end

	def show
		@stay = Stay.find params[:id]
	end
end
