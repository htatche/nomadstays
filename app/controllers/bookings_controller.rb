class BookingsController < ApplicationController
  
  def index
  end

  def show
  end

  def new
    unless current_user.has_all_data
      flash[:notice] = "In order to continue with your booking please first finish completing your account data"
      redirect_to edit_user_registration_path
    else
      @booking = Booking.new

      @stay = Stay.find(params[:stay_id])
      @room = Room.find(params[:room_id]) if params[:room_id]
    end
  end

  def create
    # binding.pry

    @room = Room.find(params[:room_id]) if params[:room_id]

    @booking = Booking.new(booking_params)
    @stay = Stay.find(params[:stay_id])

    @booking.stay_id = params[:stay_id]
    @booking.user_id = current_user.id
    @booking.date_to = @booking.date_from + @booking.stay_length_in_months.months
    @booking.paid = false

    @booking.save!

    if @booking.persisted?
      BookingMailer.booking_email(current_user).deliver
      redirect_to :action => 'show', :id => @booking.id
    else
      render "new"
    end        
  end


  def edit

  end

  def update
  end

  private

    def booking_params
      params.require(:booking).permit(:date_from, :date_to, :stay_length_in_months, :accepted, :paid, :description, :accomodation_type,
                                      :service_pickup, :service_laundry, :service_cleaning, :service_sim_card,
                                      :special_request)
    end

end