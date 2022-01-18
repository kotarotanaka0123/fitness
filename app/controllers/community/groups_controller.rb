class Community::GroupsController < CommunityController
    before_action :set_group, only: [:edit, :update]
    before_action :set_q, only: [:index, :search]

    def index
        @groups = not_joining_groups # HACK: @groupに配列で入れているが、Group::ActiveRecord_Relationの形で入れたほうが良いかも。
    end

    def search 
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params.merge(user_ids: [current_user.id], owner_id: current_user.id))
        if @group.save
            redirect_to community_group_url(@group.id), notice: "グループ「#{@group.name}」を作成しました"
        else
            render :new
        end
    end

    def show
        @group = Group.find(params[:id])
        @owner = User.find(@group.owner_id)
    end

    def edit
        redirect_to groups_path, notice: "作成者でないと編集できません。" unless @group.owner_id == current_user.id
    end

    def update 
        if @group.update(group_params)
            redirect_to groups_path, notice: 'グループを更新しました'
        else
            render :edit
        end
    end

    def destroy
        group = Group.find(params[:id])
        group.destroy
        redirect_to community_groups_url
    end

    def inviteUsers
    end

    def join
        @group = Group.find(params[:id])
        @group.users << current_user

        redirect_to community_group_url(@group.id), notice: "グループ「#{@group.name}」に参加しました！"
        # TODO: グループ参加の前にモーダルを表示
        # respond_to do |format|
        #     format.html
        #     format.js {
        #         group = @group
        #     }
        # end
    end

    private

    def group_params
        params.require(:group).permit(:name, :describe, :image)
    end

    def set_group
        @group = Group.find(params[:id])
    end

    def set_q
        @q = Group.ransack(params[:q])
    end

    def not_joining_groups
        Group.all.order(updated_at: "DESC") - User.find(current_user.id).groups
    end
end



