class Public::RelationsController < ApplicationController
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.following
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user.id)
    redirect_to request.referer
  end

  def destroy
    user = Relation.find_by(followed_id: params[:id]).followed
    current_user.unfollow(user.id)
    redirect_to request.referer
  end
end
