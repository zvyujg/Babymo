class Admin::UsersController < ApplicationController
    def top
        @users = User.all
    end
    
    def index
        search_word = params[:search]
        if search_word.present?
            @users = User.where(is_deleted: false).where(name: params[:search])
        else
            @users = User.where(is_deleted: false)    
        end
    end
    
    def show
        @user = User.find(params[:id])
        @follows = @user.following
        @followers = @user.followers
        favorite_articles = @user.favorite_articles
        @articles = @user.favorite_articles.page(params[:page])
        
        render "/public/users/show"
    end
end