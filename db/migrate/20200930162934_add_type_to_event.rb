class AddTypeToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :event, :type, :string
  end
end
