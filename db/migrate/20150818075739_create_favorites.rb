class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :user_id
      t.string :snippet_id

      t.timestamps null: false
    end
  end
end
