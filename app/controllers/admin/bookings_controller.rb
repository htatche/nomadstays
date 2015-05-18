class Admin::BookingsController < ApplicationController

  public

    def show
      @booking = Booking.find params[:id]
    end

    def accept
      @booking = Booking.find(params[:id])

      @booking.status = "accepted"

      if @booking.save
        flash[:notice] = "Great ! #{@booking.user.first_name} will soon receive a notification."

        BookingMailer.booking_accepted_nomad_email(@booking).deliver

        redirect_to admin_booking_path(stay_id: @booking.stay.id, id: @booking.id)
      else
        render admin_booking_path(stay_id: @booking.stay.id, id: @booking.id)
      end    
    end

    def reject
      @booking = Booking.find(params[:id])

      @booking.status = "rejected"

      if @booking.save
        flash[:notice] = "We are sorry that you can't welcome #{@booking.user.first_name}, maybe next time ?"

        BookingMailer.booking_rejected_nomad_email(@booking).deliver

        redirect_to admin_booking_path(stay_id: @booking.stay.id, id: @booking.id)
      else
        render admin_booking_path(stay_id: @booking.stay.id, id: @booking.id)
      end      
    end

    def cancel_by_host
      @booking = Booking.find(params[:id])

      @booking.status = "cancelled"

      if @booking.save
        flash[:notice] = "#{@booking.user.first_name}'s booking has been cancelled."

        BookingMailer.booking_cancelled_by_host_nomad_email(@booking).deliver

        redirect_to admin_booking_path(stay_id: @booking.stay.id, id: @booking.id)
      else
        render admin_booking_path(stay_id: @booking.stay.id, id: @booking.id)
      end      
    end

end