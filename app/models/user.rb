class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "50x50>" }, :default_url => "/images/:style/missing.jpeg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
