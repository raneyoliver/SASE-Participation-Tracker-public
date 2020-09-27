class CreateFormUser < ActiveRecord::Migration[6.0]
  def change
    create_table :form_user do |t|
        t.string "form_id", null: false
        t.string "user_id", null: false
    end
  end
end
