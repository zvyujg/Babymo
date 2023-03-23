class Public::FavoritesController < ApplicationController
  
  def index
    #binding.pry
    @favorites = current_user.favorites
  end
  
  def create
    @article = Article.find(params[:article_id])
    favorite = current_user.favorites.new(article_id: @article.id)
    favorite.save
    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:article_id])
    favorite = current_user.favorites.find_by(article_id: @article.id)
    favorite.destroy
    redirect_to articles_path
  end
end
