# A model for users of event forms
class User < ApplicationRecord
  validates_presence_of :id, :first_name, :last_name, :major, :graduation_year, :email
  validates_length_of :first_name, :last_name, :major, :email, maximum: 255
  validates_length_of :phone_number, maximum: 255, allow_blank: true
  validates_length_of :id, minimum: 40, maximum: 40
  validates_inclusion_of :graduation_year, in: 0o000..9999
  has_many :form_users
end
