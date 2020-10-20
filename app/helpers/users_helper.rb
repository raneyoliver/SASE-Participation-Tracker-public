# Helper functions for users controller
module UsersHelper
  def send_new_user_email(user)
    UserMailer.with(user: user).new_user_email.deliver_later
  end
end
