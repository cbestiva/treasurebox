class PostsController < ApplicationController

  def index
    @posts = Post.all

    respond_to do |f|
      f.html {render layout: false}
      f.json {render json: @posts}
    end
  end

  def show
    post = Post.find(params[:id])

    respond_to do |f|
      f.json {render json: post}
    end
  end

  def create
    post = Post.create(params[:post])

    respond_to do |f|
      f.html {redirect_to profile_path(current_user)}
      f.json {render json: post}
    end
  end

  def update
    post = Post.find(params[:id])
    post.update_attributes(params[:post])
    redirect_to profile_path(current_user)
  end

  def destroy
    post = Post.find(params[:id])
    post.delete
  end
end
