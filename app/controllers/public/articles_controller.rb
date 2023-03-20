class Public::ArticlesController < ApplicationController
   
  # before_action :authenticate_public_user!
  # before_action :posted_user!, only: [:edit, :update, :destroy]
  # impressionist :actions => [:show]

  def index
    @articles = Article.all.page(params[:page]).per(10)
  end
  
  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
  end

  # 以下を追加
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @article.save!
    # 4. トップ画面へリダイレクト
    redirect_to root_path
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def destroy
    @article = Article.find(params[:id])
    #post_image = 削除するPostImageレコードを取得
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:user_id, :title, :content, :rate, :speed, :accent, images: [])
  end

  # def posted_user!
  #   article = Article.find(params[:id])
  #   unless current_public_user.id == article.user_id
  #     redirect_to root_path
  #   end
  # end
end
