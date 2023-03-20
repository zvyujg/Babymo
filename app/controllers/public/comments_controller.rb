class Public::CommentsController < ApplicationController
  
  def create
    comment = current_user.comments.new(comment_params)
    @article = Article.find(params[:article_id])
    comment.article_id = @article.id
    #comment.score = Analyze.get_data(comment.content)
    if comment.save
      redirect_to article_path(@article.id)
    else
      flash.now[:warning] = "入力をご確認ください"
      redirect_to request.referer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @comment_id = @comment.reply_to
      @reply_count = Comment.where(reply_to: @comment_id).count
    else
      flash.now[:warning] = '削除に失敗しました'
      redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :reply_to)
  end
end
