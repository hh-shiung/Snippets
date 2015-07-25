class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.boolean :is_email_confirm
      t.boolean :is_active
      t.integer :user_type
      t.string :token
      # t.string :avatar

      t.timestamps null: false
    end
  end
end
