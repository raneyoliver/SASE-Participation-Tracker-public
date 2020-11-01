# Mailer for emails related to users
class UserMailer < ApplicationMailer
  default from: 'sasetamu.logistics@gmail.com'

  def new_user_email
    @user = params[:user]
    @name = "#{@user.first_name} #{@user.last_name}"
    subject = 'Welcome to the SASE Participation Tracker!'
    mail(to: @user.email, subject: subject)
  end
end
