class CommentsController < ApplicationController

  before_action :setCurrentTestimony
  before_action :setCurrentUser

  def new
    @testimony = Testimony.find_by_id(params[:id])
    @comment = Comment.new
    render :new
  end

  def create
   @comment = Comment.new(comment_params)
   @comment.user_id = current_user.id
   @comment.testimony_id = @testimony.id
  if @comment.save
    redirect_to testimony_path(@testimony.id)
  else
    flash.now[:danger] = "error"
  end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def edit
    @comment = Comment.find(params[:id])
    if allowed?(@comment.user_id)
    render :edit
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if allowed?(@comment.user_id)
      @comment.update(comment_params)
      redirect_to testimony_path
    else
      redirect_to testimony_path
      flash[:error] = 'You dont have access to edit this account'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def setCurrentTestimony
    @testimony = Testimony.find(params[:testimony_id])
  end

  def setCurrentUser
    @user = current_user
  end

  def comment_params
  params.require(:comment).permit(:comment, :testimony_id)
  end
end
