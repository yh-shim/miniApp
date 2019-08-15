class PostsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    @posts = Post.includes(:user).all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
  end

  def create
    Post.create(text: strong_params[:text], user_id: current_user.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if post.user_id == current_user.id
    redirect_to("/users/current_user.id")
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    # require 'date'
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(text: strong_params[:text])
    end
  end

  private
  def strong_params
    params.permit(:text)
  end

  def move_to_index
    redirect_to(action: :index) unless user_signed_in?
  end
end
