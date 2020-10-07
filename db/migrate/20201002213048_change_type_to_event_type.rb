class ChangeTypeToEventType < ActiveRecord::Migration[6.0]
  change_table :event do |t|
    t.rename :type, :event_type
  end
end
