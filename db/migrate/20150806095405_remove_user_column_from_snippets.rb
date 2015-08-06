class RemoveUserColumnFromSnippets < ActiveRecord::Migration
  def up
    remove_column :snippets, :user_id
  end

  def down
    add_column :snippets, :user_id, :integer
  end
end
