class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:welcome, :show, :edit, :update]
  before_action :correct_user!, only: [:edit, :update]

  def top
  end
  
  def index 
  end

  def welcome
    @user = current_learner_user
    @languages = Language.all
  end

  def show
    @user = User.find(params[:id])
    @follows = @user.following
    @followers = @user.followers
  end

  def edit
    @user = User.find(params[:id])
    @languages = Language.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if params[:welcome]
        redirect_to public_articles_path(welcome:"")
      else
        redirect_to public_user_path(current_public_user)
      end
    else
      @languages = Language.all
      flash.now[:warning] = '入力をご確認ください'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :language, :level, :introduction, :profile, :profile_image)
  end

  def correct_user!
    user = User.find(params[:id])
    unless current_public_user.id == user.id
      redirect_to root_path
    end
  end
end
