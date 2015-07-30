class AddUsersToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :user_id, :integer
    add_foreign_key :snippets, :users
  end
end
