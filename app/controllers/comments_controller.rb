class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: root_path, notice: t('controllers.common.notice_create', name: Comment.model_name.human)) }
      else
        format.html { redirect_back(fallback_location: root_path, alert: t('controllers.common.notice_cannot_create', name: Comment.model_name.human)) }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.user_id == current_user.id
        @comment.destroy
        format.html { redirect_back(fallback_location: root_path, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)) }
      else
        format.html { redirect_back(fallback_location: root_path, alert: t('controllers.common.notice_cannot_destroy', name: Comment.model_name.human)) }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :user_id)
  end
end
