# A model for users of event forms
class User < ApplicationRecord
  validates_presence_of :id, :first_name, :last_name, :major, :graduation_year, :email
  validates_length_of :first_name, :last_name, :major, :email, maximum: 255
  validates_length_of :id, minimum: 40, maximum: 40
  validates_inclusion_of :graduation_year, in: 0..9999
  validates_format_of :email, with: Regexp.new('\A(?:[a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*'\
                                               '|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x'\
                                               '0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]'\
                                               '(?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9'\
                                               ']?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0'\
                                               '-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x0'\
                                               '1-\x09\x0b\x0c\x0e-\x7f])+)\])\z')
  validates_format_of :phone_number, with: Regexp.new('\A[0-9]{10}\z'), allow_blank: true
  has_many :form_users
end
