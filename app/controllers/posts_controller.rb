class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :edit, :update, :destroy]

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
    @sig = s3_upload_signature
    @policy = s3_upload_policy_document()
    puts @sig

    respond_to do |f|
      f.html {render layout: false}
      f.json {render json: @posts}
    end
  end

  def create
    # binding.pry
    new_post = params.require(:post).permit(:city, :name, :category, :description, :price, :image)
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

  def render_new_photo
    respond_to do |f|
      f.json {
        render json: {
          policy: s3_upload_policy_document,
          signature: s3_upload_signature,
          key: key
        }.to_json
      }
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

  protected

  def s3_upload_policy_document
    return @policy if @policy
    ret = {"expiration" => 5.hours.from_now.xmlschema,
      "conditions" => [
        {"bucket" => "treasurebox-photos"},
        ["starts-with", "$key", "uploads/"],
        {"acl" => "public-read"},
        {"success_action_redirect" => profile_url(current_user)},
        # {"success_action_status" => "200"},
        ["starts-with", "$Content-Type", ""],
        ["content-length-range", 0, 1048576]
      ]
    }
    @policy = Base64.encode64(ret.to_json).gsub(/\n/,'')
  end


  def s3_upload_signature
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), 
      ENV['S3_SECRET_KEY'], s3_upload_policy_document)).gsub("\n","")
  end

end
