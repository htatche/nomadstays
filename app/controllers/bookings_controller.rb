class BookingsController < ApplicationController
  
  def index
    @bookings = current_user.bookings
  end

  def show
    @booking = Booking.find params[:id]
  end

  def new
    unless current_user.has_all_data
      flash[:notice] = "In order to continue with your booking please first finish completing your account data"
      redirect_to edit_user_registration_path
      # TODO: Once the account is updated, send him back to new_booking_path
    else
      @booking = Booking.new

      @stay = Stay.find(params[:stay_id])
      @room = Room.find(params[:room_id]) if params[:room_id]

      @booked_dates = @stay.booked_dates
    end
  end

  def create
    @room = Room.find(params[:room_id]) if params[:room_id]

    @booking = Booking.new(booking_params)
    @stay = Stay.find(params[:stay_id])

    @booking.stay_id = params[:stay_id]
    @booking.user_id = current_user.id
    @booking.date_to = @booking.date_from + @booking.stay_length_in_months.months
    @booking.paid = false
    @booking.status = "pending"

    @booking.save

    # TODO: Show error if date overlap with another booking

    if @booking.persisted?
      flash[:notice] = "Thanks for requesting a booking with us ! You will soon receive a confirmation email."

      BookingMailer.booking_request_nomad_email(current_user).deliver
      BookingMailer.booking_request_host_email(current_user, @stay.user, @stay).deliver

      redirect_to :action => 'show', :id => @booking.id
    else
      render "new"
    end 

  end


  def edit

  end

  def update
  end

  def accept
    @booking = Booking.find(params[:id])

    @booking.status = "accepted"

    if @booking.save
      redirect_to @booking
    else
      render booking_path(stay_id: @booking.stay.id, booking_id: @booking.id)
    end      
  end

  def accept
    @booking = Booking.find(params[:id])

    @booking.status = "rejected"

    if @booking.save
      redirect_to @booking
    else
      render booking_path(stay_id: @booking.stay.id, booking_id: @booking.id)
    end      
  end

  private

    def booking_params
      params.require(:booking).permit(:date_from, :date_to, :stay_length_in_months, :status, :paid, :description, :accomodation_type,
                                      :service_pickup, :service_laundry, :service_cleaning, :service_sim_card,
                                      :special_request)
    end

end