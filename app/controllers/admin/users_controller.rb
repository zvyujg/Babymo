class Admin::UsersController < ApplicationController
    def top
        @users = User.all
    end
    
    def index
        
    end
end