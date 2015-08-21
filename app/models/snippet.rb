class Snippet < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # is_impressionable
end
