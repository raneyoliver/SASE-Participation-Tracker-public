class RemoveHasRsvpFormFromEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :event, :has_rsvp_form, :boolean
  end
end
