class Public::ArticlesController < ApplicationController
   
  # before_action :authenticate_public_user!
  # before_action :posted_user!, only: [:edit, :update, :destroy]
  # impressionist :actions => [:show]

  def index
    @articles = Artcle.all
  end
  
  def new
    @article = Artcle.new
  end

  def show
  end

  def create
  end

  def edit
  end

  

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:user_id, :title, :content, :image, :rate, :difficulty,  :practicality, :speed, :accent)
  end

  # def posted_user!
  #   article = Article.find(params[:id])
  #   unless current_public_user.id == article.user_id
  #     redirect_to root_path
  #   end
  # end
end
