class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = Micropost.find(params[:micropost_id]) 
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = '投稿にコメントしました。'
      redirect_back(fallback_location: root_path)
    else
      @micropost = Micropost.find(params[:micropost_id]) 
      flash.now[:danger] = '投稿へのコメントに失敗しました。'
      render 'microposts/show'
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = '投稿へのコメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
