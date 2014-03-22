class PostItemsController < ApplicationController
  def index
    posts = PostItem.all 

    respond_to do |f|
      f.html {redirect_to root_path}
      f.json {render :json => posts}
    end
  end

  def show
    if params[:format] == "json"
    end
    render layout: false
  end

  def create
    new_post_item = params.require(:post_item).permit(:name, :category, :description, :price)
    post = PostItem.create(new_post_item)

    respond_to do |f|
      f.html {redirect_to profile_path}
      f.json {render json: post}
    end
  end

end
