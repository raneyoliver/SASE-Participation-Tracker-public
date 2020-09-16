class CreateEvent < ActiveRecord::Migration[6.0]
  def change
    create_table :event do |t|
      t.string :name
      t.text :description
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
