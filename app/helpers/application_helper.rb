# Helper methods for Application
module ApplicationHelper
  def hash_user_uin(value)
    Digest::SHA1.hexdigest value
  end
end
