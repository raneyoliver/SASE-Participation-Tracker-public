class SignInForm < ActiveRecord::Migration[6.0]
  def change
    create_table :form do |t|
      t.string :uin
    end
  end
end
