class AddHasRsvpFormToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :event, :has_rsvp_form, :boolean
  end
end
