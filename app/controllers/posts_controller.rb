class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index 
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    tag_list = params[:post][:tagname].split(",")
    @post.save_posts(tag_list)
    redirect_to root_path
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end


  private
  def post_params
    params.require(:post).permit(:text, :image, tag_ids:[]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end
