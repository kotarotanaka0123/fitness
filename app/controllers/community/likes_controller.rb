class Community::LikesController < CommunityController
    def create
        @like = current_user.likes.create(message_id: params[:id])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @like = Like.find_by(message_id: params[:id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
    end
end
