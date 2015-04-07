class BookingsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @booking = Booking.new
    @stay = Stay.find(params[:stay_id])
end

  def create
    @booking = Booking.new(booking_params)
    @stay = Stay.find(params[:stay_id])

    @booking.stay_id = params[:stay_id]
    @booking.user_id = current_user.id
    # binding.pry
    @booking.date_to = @booking.date_from + @booking.stay_length_in_months.months
    @booking.paid = false

    @booking.save!

    if @booking.persisted?
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