class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "90x90>", :thumb => "30x30>" }, :default_url => ":styles/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
