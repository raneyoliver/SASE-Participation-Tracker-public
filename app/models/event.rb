# Event model for Rails
class Event < ApplicationRecord
  has_many :forms
  validates :start_time, date: true, null: false
  validates :end_time, date: true, null: false
end
