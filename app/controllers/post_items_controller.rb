class PostItemsController < ApplicationController
  def create
    new_post_item = params.require(:post_item).permit(:name, :category, :description, :price)
    post_item = PostItem.create(new_post_item)

    respond_to do |f|
      f.html {redirect_to profile_path}
      f.json {render json: post_item}
    end
  end
end
