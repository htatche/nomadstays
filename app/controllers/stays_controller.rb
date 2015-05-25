class StaysController < ApplicationController

  public

    def index
      if params[:q]
        query = params[:q].reject {|i,j|  i == "house_nomad_house_eq_any" && j == "0"}
        @q = Stay.ransack(query)
        @stays = @q.result(distinct: true)      
      else
        @q = Stay.ransack(params[:q])
        @stays = @q.result(distinct: true)
      end
    end      

    def show
      @stay = Stay.find params[:id]
      @stay_photos = @stay.stay_photos.all

      @booked_dates = @stay.booked_dates
    end

  	def new
  		@stay = Stay.new
      @stay_photos = @stay.stay_photos.build    

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
      @stay.country_name = ISO3166::Country[@stay.country_code]
      @stay.full_address = @stay.build_full_address

      # Apartment / House

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
        params[:stay_photos][:file].each do |a|
          @stay_photo = @stay.stay_photos.create!(:file => a, :stay_id => @stay.id)
        end  

        # First photo will be the cover one automatically
        @stay.stay_photos.first.update(cover: true)

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

      @stay.country_name = ISO3166::Country[country_code]
      @stay.full_address = @stay.build_full_address

      if @stay.update(stay_params)

        if params[:stay_photos]
          params[:stay_photos][:file].each do |a|
            @stay_photo = @stay.stay_photos.create!(:file => a, :stay_id => @stay.id)
          end  
        end

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
                                   :latitude, :longitude, :street_address, :city, :state, :country_code,
                                   :wifi, :wifi_speed, :mobile_data, :mobile_data_speed,
                                   :terrace, :router_access, :desk,
                                   :service_pickup, :service_laundry, :service_cleaning, :service_sim_card,
                                   :service_pickup_price, :service_laundry_price, :service_cleaning_price, :service_sim_card_price,
                                   :monthly_price,
                                   :available,
                                   stay_photos_attributes: [:id, :stay_id, :file]
                                   )
    end

end