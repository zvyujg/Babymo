class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:welcome, :show, :edit, :update]
  before_action :correct_user!, only: [:edit, :update]

  def top
  end
  
  def index 
    @users = User.where(is_deleted: false).where(name: params[:search])
    
  end
  
  def show
    @user = User.find(params[:id])
    @follows = @user.following
    @followers = @user.followers
    favorite_articles = @user.favorite_articles
    @articles = @user.favorite_articles.page(params[:page])
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  def withdraw
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :language, :level, :introduction, :profile, :profile_image)
  end

  def correct_user!
    user = User.find(params[:id])
    unless current_user.id == user.id
      redirect_to root_path
    end
  end
end
