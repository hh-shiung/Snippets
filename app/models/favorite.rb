class Favorite < ActiveRecord::Base
  belongs_to :users, class_name: "User"
  belongs_to :snippets, class_name: "Snippets"
  validates :user_id, presence: true
  validates :snippet_id, presence: true
end
