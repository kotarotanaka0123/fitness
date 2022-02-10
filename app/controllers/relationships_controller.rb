class RelationshipsController < ApplicationController
    before_action :set_q, only: [:index, :search]
    #————————フォロー・フォロワー一覧を表示する-————————————
    def index
        @user = User.find(params[:user_id])
        @followingUsers = @user.followings
        @followerUsers = @user.followers
    end

    def search
        @users = @q.result
    end

    def create
        current_user.follow(params[:id])
        redirect_to request.referer
    end
    
    def destroy
        current_user.unfollow(params[:id])
        redirect_to request.referer  
    end
    
    private

    def set_q
        @q = User.ransack(params[:q])
    end
end
