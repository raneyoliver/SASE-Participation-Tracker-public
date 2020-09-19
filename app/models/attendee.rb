# A model for attendees of events
class Attendee < ApplicationRecord
  validates_presence_of :UIN, :first_name, :last_name, :major, :graduation_year, :email
  validates_length_of :first_name, :last_name, :major, :email, maximum: 255
  validates_length_of :phone_number, maximum: 255, allow_blank: true
  validates_length_of :UIN, minimum: 9, maximum: 9
  validates_inclusion_of :graduation_year, in: 2000..2050
end
