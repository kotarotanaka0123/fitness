class LikesController < ApplicationController
    def create
        @like = current_user.likes.create(message_id: params[:message_id])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        binding.pry
        @like = Like.find_by(message_id: params[:message_id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
    end
end
