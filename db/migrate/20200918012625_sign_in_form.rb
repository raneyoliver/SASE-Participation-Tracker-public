class SignInForm < ActiveRecord::Migration[6.0]
  def change
    create_table(:form, id: :string) do |t|
      t.integer :event_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :form_type
      t.string :data
    end
  end
end
