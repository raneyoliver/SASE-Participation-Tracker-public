class ChangeEventDateTimeTypes < ActiveRecord::Migration[6.0]
  def up
    change_column :event, :start_time, 'timestamp USING CAST(start_time AS timestamp)'
    change_column :event, :end_time, 'timestamp USING CAST(start_time AS timestamp)'
  end

  def down
    change_column :event, :start_time, :string
    change_column :event, :end_time, :string
  end
end
