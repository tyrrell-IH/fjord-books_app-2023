class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_path(comment_params[:commentable_id]), notice: 'comment saved' }
      else
        format.html { redirect_to book_path(comment_params[:commentable_id]), alert: 'comment not saved' }
      end
    end
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :user_id)
  end
end
