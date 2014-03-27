class Post < ActiveRecord::Base
  # attr_accessible :image
  belongs_to :user
  # belongs_to :category

  mount_uploader :image, ImageUploader
end
