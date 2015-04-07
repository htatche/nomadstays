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

      @stay = Stay.new(stay_params)
      @stay.accomodation_type = accomodation_type
      @stay.user_id = current_user.id
      @stay.full_address = @stay.build_full_address

      if input[:accomodation_type] == "House"

        house_params = input[:house_attributes]

        @stay.house = House.new(
          :stay_id => @stay.id,

          :garden  => house_params[:garden],
          :terrace  => house_params[:terrace],
          :alarm  => house_params[:alarm],          
          :nomad_house  => house_params[:nomad_house]
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

      @stay.save!

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
      params.require(:stay).permit(:title, :description, :accomodation_type,
                                   :latitude, :longitude, :street_address, :city, :state, :country,
                                   :wifi, :wifi_speed, :mobile_data, :mobile_data_speed,
                                   :terrace, :router_access, :desk,
                                   :service_pickup, :service_laundry, :service_cleaning, :service_sim_card,
                                   :service_pickup_price, :service_laundry_price, :service_cleaning_price, :service_sim_card_price,
                                   :monthly_price
                                   )
    end

end