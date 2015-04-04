class StaysController < ApplicationController

  public

    def index
      @stays = current_user.stays
    end

    def show
      @stay = Stay.find params[:id]
    end

  	def new
  		@stay = Stay.new

      @stay.apartment = Apartment.new
      @stay.house =     House.new
  	end

  	def create
  		input = params[:stay]

      if input[:accomodation_type] == "Select one"
        accomodation_type = ""
      else
        accomodation_type = input[:accomodation_type]
      end

      apartment_params = 

  		@stay = Stay.new(
        :user_id => current_user.id,

    		:title => input[:title],
        :description => input[:description],

    		:full_street_address => input[:full_street_address],
    		:city  => input[:city],
    		:state  => input[:state],
    		:country  => input[:country],

    		:latitude => input[:latitude],
    		:longitude => input[:longitude],

        :accomodation_type => accomodation_type,

    		:wifi => input[:wifi],
    		:wifi_speed => input[:wifi_speed],
    	)

      if input[:accomodation_type] == "House"

        house_params = input[:house_attributes]

        @stay.house = House.new(
          :stay_id => @stay.id,

          :garden  => house_params[:garden],
          :terrace  => house_params[:terrace],
          :alarm  => house_params[:alarm]          
        )

      elsif input[:accomodation_type] == "Apartment"

        apartment_params = input[:apartment_attributes]

        @stay.apartment = Apartment.new(
          :stay_id => @stay.id,

          :nrooms       => apartment_params[:nrooms],
          :floor        => apartment_params[:floor],
          :lift         => apartment_params[:lift],          
          :security     => apartment_params[:security]
        )

      end    

      @stay.save

      if @stay.persisted?
        redirect_to :action => 'show', :id => @stay.id
      else
        # Renders the nested form for the child that was not created before
        @stay.apartment = Apartment.new     if input[:accomodation_type] == "House"
        @stay.house = House.new             if input[:accomodation_type] == "Apartment"

        render "new"
      end    

  	end

    def edit
      @stay = Stay.find params[:id]
    end

    def update
      @stay = Stay.find(params[:id])
      @stay.update(stay_params)

      if @stay.update(stay_params)
        redirect_to @stay
      else
        render "edit"
      end         
    end

    def destroy
      @stay = Stay.find(params[:id])
      @stay.destroy
      redirect_to stays_path
    end

  private

    def stay_params
      params.require(:stay).permit(:title, :description)
    end

end