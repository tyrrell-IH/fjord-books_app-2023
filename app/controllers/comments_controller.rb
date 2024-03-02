# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    reference_source = @comment.commentable
    if @comment.save
      redirect_to reference_source, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to reference_source, alert: t('controllers.common.notice_cannot_create', name: Comment.model_name.human)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    reference_source = @comment.commentable
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to reference_source, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      redirect_to reference_source, alert: t('controllers.common.notice_cannot_destroy', name: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :user_id)
  end
end
