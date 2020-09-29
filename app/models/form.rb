# Form model for Rails
class Form < ApplicationRecord
  belongs_to :event
  has_many :form_users

  def user_count
    self.form_users.length
  end
end
