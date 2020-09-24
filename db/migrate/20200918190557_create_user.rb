class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :user, id: :string do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :major, null:false
      t.integer :graduation_year, null: false
      t.string :email, null: false
      t.string :phone_number

      t.timestamps
    end
  end
end
