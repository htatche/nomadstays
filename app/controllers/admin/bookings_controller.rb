class Admin::BookingsController < ApplicationController

  public

    def show
      @booking = Booking.find params[:id]
    end
    
end