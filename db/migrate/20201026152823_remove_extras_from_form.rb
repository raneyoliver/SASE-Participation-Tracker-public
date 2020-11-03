class RemoveExtrasFromForm < ActiveRecord::Migration[6.0]
  def change
    remove_column :form, :questions, :string
    remove_column :form, :start_time, :datetime
    remove_column :form, :end_time, :datetime
  end
end
