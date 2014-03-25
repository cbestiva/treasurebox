class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all

    respond_to do |f|
      f.html {render layout: false}
      f.json {render json: @posts}
    end
  end

  def show
    # @posts = Post.where(:user_id => current_user.id)
    @posts = current_user.posts

    respond_to do |f|
      f.html {render layout: false}
      f.json {render json: @posts}
    end
  end

  def create
    new_post = params.require(:post).permit(:city, :name, :category, :description, :price)
    @post = current_user.posts.create(new_post)

    respond_to do |f|
      f.html {redirect_to profile_path(current_user)}
      f.json {render json: @post}
    end
  end

  def update
    post = Post.find(params[:id])
    post.update_attributes(params[:post].permit(:name,:category, :description,:price))

    respond_to do |f|
      f.html {redirect_to profile_path(current_user)}
      f.json {render json: post, status: 200}
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.delete

    respond_to do |f|
      f.html {redirect_to profile_path(current_user)}
      f.json {render json: post, status: 200}
    end
  end
end
