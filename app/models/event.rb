# Event model for Rails
class Event < ApplicationRecord
  has_many :forms
  validates :name, null: false
  validates :start_time, date: true, null: false
  validates :end_time, date: true, null: false
  validates :event_type, null: false
end
