class Admin::CommentsController < ApplicationController
    def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @comment_id = @comment.reply_to
      @reply_count = Comment.where(reply_to: @comment_id).count
      redirect_to admin_article_path(@comment.article)
    else
      flash.now[:warning] = '削除に失敗しました'
      redirect_to request.referer
    end
  end
end
