class Public::ArticlesController < ApplicationController
   
  # before_action :authenticate_public_user!
  # before_action :posted_user!, only: [:edit, :update, :destroy]
  # impressionist :actions => [:show]

  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end

  def show
  end

  # 以下を追加
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @article = Article.new(article_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @article.save
    # 4. トップ画面へリダイレクト
    redirect_to root_path
  end

  def edit
  end

  

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:user_id, :title, :content, :rate, :difficulty, :practicality, :speed, :accent, images: [])
  end

  # def posted_user!
  #   article = Article.find(params[:id])
  #   unless current_public_user.id == article.user_id
  #     redirect_to root_path
  #   end
  # end
end
