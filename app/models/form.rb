# Form model for Rails
class Form < ApplicationRecord
  belongs_to :event
  validates :event, presence: true
  validates_presence_of :id, :form_type
  has_many :form_users

  def user_count
    form_users.length
  end
end
