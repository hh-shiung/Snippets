class CreateUserfeedbacks < ActiveRecord::Migration
  def change
    create_table :userfeedbacks do |t|
      t.string :email
      t.string :feedback

      t.timestamps null: false
    end
  end
end
