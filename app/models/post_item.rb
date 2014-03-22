class PostItem < ActiveRecord::Base
  belongs_to :user
  att_accessible :name, :category, :description, :price, :image
  mount_uploader :image, ImageUploader
end
