class AddSignInRestrictionToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :event, :sign_in_restricted, :boolean
    add_column :event, :rsvp_restricted, :boolean
  end
end
