class PostItem < ActiveRecord::Base
  belongs_to :user
  # belongs_to :category
  # attr_accessible :name, :category, :description, :price, :image
  mount_uploader :image, ImageUploader
end
