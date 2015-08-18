class AddingAssociationFavorite < ActiveRecord::Migration
  def up
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :snippets
  end

  def down
    remove_foreign_key :favorites, :users
    remove_foreign_key :favorites, :snippets
  end
end
