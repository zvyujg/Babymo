class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:welcome, :show, :edit, :update]
  before_action :correct_user!, only: [:edit, :update]

  def top
  end
  
  def index 
    @users = User.where(is_deleted: false)
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
  
  def search
    @users = if params[:search].present?
              User.where('name LIKE ?',
                        "%#{params[:search]}%").where(is_deleted: false)
                 #.paginate(page: params[:page], per_page: 12).recent
             else
              User.none
             end
    pp "=============="
    pp @users
    render 'index'
  end
  
  def create
    @user = User.new(user_params)
    @user.user_id=current_user.id
    # 受け取った値を,で区切って配列にする
    tag_user=params[:post][:name].split(',')
    if @user.save
      @user.save_tag(tag_user)
      redirect_to posts_path(@user),notice:'投稿完了しました:)'
    else
      render:new
    end
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
    params.require(:user).permit(:name, :email, :image, :language, :level, :introduction, :profile)
  end

  def correct_user!
    user = User.find(params[:id])
    unless current_user.id == user.id
      redirect_to root_path
    end
  end
end
