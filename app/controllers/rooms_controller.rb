class RoomsController < ApplicationController

  public

    def show
      @stay = Stay.find params[:stay_id]
      @room = Room.find params[:id]
    end

  	def new
  		@stay = Stay.find params[:stay_id]
  		@room = Room.new 
  	end

  	def create
      @stay = Stay.find(params[:stay_id])
  		@room = Room.new(room_params)
      @room.stay_id = @stay.id

      # Rooms are linked to an apartment or a house, not to a stay
      # if @stay.house
        # @room.house_id = @stay.house.id
      # elsif @stay.apartment
        # @room.apartment_id = @stay.apartment.id
      # end      

  		@room.save

    	if @room.persisted?
    		redirect_to stay_room_path(stay_id: @stay.id, id: @room.id)
    	else
    		render "new"
    	end
  	end	

    def edit
      @room = Room.find params[:id]
      @stay = Stay.find params[:stay_id]
    end

    def update
      @room = Room.find(params[:id])
      @stay = Stay.find params[:stay_id]

      if @room.update(room_params)
        redirect_to stay_room_path(stay_id: @stay.id, id: @room.id)
      else
        render "edit"
      end         
    end

    def destroy
      @room = Room.find(params[:id])
      @stay = Stay.find(params[:stay_id])
      @room.destroy
      redirect_to stay_path(id: @stay.id)
    end

  private

    def room_params
      params.require(:room).permit(:title, :sqm, :desk, :kitchen_access)
    end  

end
