class BookingMailer < ApplicationMailer

  def booking_request_nomad_email(user)
    @user = user
    mail(to: @user.email, subject: 'You just booked a stay !')
  end  

  def booking_request_host_email(nomad, host, stay)
    @nomad = nomad
    @host  = host
    @stay  = stay
    mail(to: @nomad.email, subject: 'A nomad booked one of your stays !')
  end  

end
