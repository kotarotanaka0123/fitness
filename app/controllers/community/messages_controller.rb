class Community::MessagesController < CommunityController
    before_action :set_group 

    def index
        @messages = @group.messages.includes(:user) # NOTE:「n+1問題」を避けるために、includes(:user)の記述を忘れずに行いましょう。
    end

    def new
        @message = Message.new
    end

    def show
        @message = @group.messages.find(params[:id])
    end

    def create
        @message = @group.messages.new(message_params)
        # return redirect_to group_messages_path(@group) if (params[:message][:content].blank? && params[:message][:image].blank?)
        if @message.save
            redirect_to community_group_message_path(@group, @message), notice: 'メッセージが投稿されました'
        else
            @messages = @group.messages.includes(:user)
            flash.now[:notice] = 'メッセージを入力してください。'
            render :index
        end
    end


    private

    def message_params
        params.permit(:content, :image).merge(user_id: current_user.id)
    end

    def set_group 
        @group = Group.find(params[:group_id])
    end
end
