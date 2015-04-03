class StaysController < ApplicationController
	def new
		@stay = Stay.new

    @stay.apartment = Apartment.new
    @stay.house =     House.new
	end

	def create
		input = params[:stay]

		@stay = Stay.new(
      :user_id => 1,

  		:title => input[:title],
      :description => input[:description],

  		:full_street_address => input[:full_street_address],
  		:city  => input[:city],
  		:state  => input[:state],
  		:country  => input[:country],

  		:latitude => input[:latitude],
  		:longitude => input[:longitude],

      :accomodation_type => input[:accomodation_type],

  		:wifi => input[:wifi],
  		:wifi_speed => input[:wifi_speed]
  	)

    @stay.save

    if input[:accomodation_type] == "House"

      house_params = input[:house_attributes]

      @stay.house = House.new(
        :stay_id => @stay.id,

        :garden  => house_params[:garden],
        :terrace  => house_params[:terrace],
        :alarm  => house_params[:alarm]          
      )

      @stay.house.save!
      type = @stay.house

    elsif input[:accomodation_type] == "Apartment"

      apartment_params = input[:apartment]

      @stay.apartment = Apartment.new(
        :stay_id => @stay.id,

        :nrooms       => apartment_params[:nrooms],
        :floor        => apartment_params[:floor],
        :lift         => apartment_params[:lift],          
        :security     => apartment_params[:security],
      )

      @stay.apartment.save!        
      type = @stay.apartment

    end      

    if @stay.persisted? and type.persisted?
      redirect_to :action => 'show', :id => @stay.id
    else
      render "new"
    end    

	end

  def index
    @stays = current_user.stays
  end

	def show
    @stay = Stay.find params[:id]

    # if @stay.has_rooms?
      # @has_rooms = @stay.rooms.any?
    # end

	end
end