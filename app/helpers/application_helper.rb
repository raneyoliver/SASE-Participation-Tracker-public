# Helper methods for Application
module ApplicationHelper
  def check_auth
    Admin.find_by(id: session[:current_user_id])
  end

  def hash_user_uin(value)
    Digest::SHA1.hexdigest value
  end
end
