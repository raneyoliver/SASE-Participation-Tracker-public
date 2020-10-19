class AddRestrictionToForm < ActiveRecord::Migration[6.0]
  def change
    remove_column :event, :sign_in_restricted, :boolean
    remove_column :event, :rsvp_restricted, :boolean
    add_column :form, :time_restricted, :boolean
  end
end
