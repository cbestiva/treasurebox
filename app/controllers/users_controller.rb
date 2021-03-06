class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    @user = current_user

    @posts = current_user.posts

    respond_to do |f|
      f.html
      f.json {render json: @user.as_json(include: :posts)}
    end
  end

  def new
  end

  def new_form
    @user = User.new
    render layout: false 
  end

  def sign_up
  end

  def sign_up_form
    @user = User.new
    render layout: false 
  end


end
