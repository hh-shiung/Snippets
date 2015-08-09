class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # has_attached_file :avatar, :styles => { :medium => "90x90>", :thumb => "30x30>" }, :default_url => ":styles/missing.jpg"


  #added for paperclip-dropbox gem
has_attached_file :avatar,
 :storage => :dropbox,
:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
:default_url => ":styles/missing.jpg",
 :styles => { :medium => "300x300" , :thumb => "100x100>"},
:dropbox_options => {
:path => proc { |style| "#{Rails.env}/#{style}/#{id}_#{avatar.original_filename}"},:unique_filename => true
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Associate many Snippets
  has_many :snippets, dependent: :destroy

  # Associate many Favorites
  # has_many :favorites, dependent: :destroy
end
