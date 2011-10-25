class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new(params[:post])
  end
  
  def create
    add_post = AddPost.new(params[:post])
    if add_post.process
      flash[:info] = "Thanks for the post!"
    else
      flash[:error] = "Error saving post"
    end
    redirect_to "/posts"
  end
end
