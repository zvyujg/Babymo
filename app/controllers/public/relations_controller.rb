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
    user = User.find(params[:followed_id])
    current_public_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = Relation.find_by(followed_id: params[:id]).followed
    current_public_user.unfollow(user)
    redirect_to request.referer
  end
end
