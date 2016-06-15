class Testimony < ActiveRecord::Base
  require 'carrierwave'
   mount_uploader :picture, PictureUploader
   mount_uploader :video, VideoUploader
   belongs_to :user
   has_many :comments, dependent: :destroy
   accepts_nested_attributes_for :comments, allow_destroy: true
end
