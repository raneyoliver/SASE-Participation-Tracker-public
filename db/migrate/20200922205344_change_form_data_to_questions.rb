class ChangeFormDataToQuestions < ActiveRecord::Migration[6.0]
  def change
    change_table :form do |t|
      t.rename :data, :questions
    end
  end
end
