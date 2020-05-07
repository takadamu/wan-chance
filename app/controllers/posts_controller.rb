class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index 
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to root_path
  end
  
  def show
    @post = Post.find(params[:id])
  end

  
  private
  def post_params
    params.require(:post).permit(:text, :image,).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end
