class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :snippet_title
      t.text :snippet_description
      t.text :snippet_content
      t.integer :snippet_view_count

      t.timestamps null: false
    end
  end
end
