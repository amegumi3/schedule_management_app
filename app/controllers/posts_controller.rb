class PostsController < ApplicationController
  def index
    @total = Post.count
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:start]
      @posts = Post.start  
    else    
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :start_date, :end_date, :all_day, :contents))
   
   
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      render  "new", status: :unprocessable_entity
    end  
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:title, :start_date, :end_date, :all_day, :contents))
      redirect_to posts_path
    else
      render "edit", status: :unprocessable_entity
    end    
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice]  = "削除しました"
    redirect_to posts_path
  end
end
