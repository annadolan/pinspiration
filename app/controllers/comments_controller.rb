class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to comments_path
      flash[:success] = "Your comment has been saved."
    else
      flash.now[:error] = "Please try again."
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comments_path
      flash[:sucess] = "Your comment has been updated."
    else
      flash.now[:error] = "Please try again."
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    flash[:success] = "Your comment has been deleted."
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
