class BookingMailer < ApplicationMailer

  def booking_email(user)
    @user = user
    mail(to: @user.email, subject: 'You just booked a stay !')
  end  

end
