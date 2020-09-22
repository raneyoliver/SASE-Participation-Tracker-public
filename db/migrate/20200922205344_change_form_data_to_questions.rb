class ChangeFormDataToQuestions < ActiveRecord::Migration[6.0]
  change_table :form do |t|
    t.rename :data, :questions
  end
end
