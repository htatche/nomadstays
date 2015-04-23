class BookingMailer < ApplicationMailer

  def booking_request_nomad_email(user)
    @user = user
    mail(to: @user.email, subject: "You just booked a stay !")
  end  

  def booking_request_host_email(nomad, host, stay)
    @nomad = nomad
    @host  = host
    @stay  = stay
    mail(to: @nomad.email, subject: "A nomad booked one of your stays !")
  end  

  def booking_accepted_nomad_email(booking)
    @booking  = booking
    mail(to: @booking.user.email, subject: "Your host is welcoming you in #{@booking.stay.title} !")
  end  

  def booking_rejected_nomad_email(booking)
    @booking  = booking
    mail(to: @booking.user.email, subject: "Sorry, your host can't welcome you right now at #{@booking.stay.title}")
  end 

  def booking_cancelled_by_host_nomad_email(booking)
    @booking  = booking
    mail(to: @booking.user.email, subject: "Sorry, your host has cancelled your booking for #{@booking.stay.title}")
  end 

  def booking_cancelled_by_nomad_host_email(booking)
    @booking  = booking
    mail(to: @booking.user.email, subject: "Sorry, a booking at #{@booking.stay.title} has been cancelled")
  end 

end
