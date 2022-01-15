class Community::GroupsController < CommunityController
    before_action :set_group, only: [:edit, :update]
    before_action :set_q, only: [:index, :search]

    def index
        # groupsを自分の属している物以外表示させる。
        @groups = Group.all.order(updated_at: "DESC")
    end

    def search 
    end

    def new
        @group = current_user.groups.new
    end

    def create
        @group = current_user.groups.new(group_params)
        binding.pry
        if @group.save!
            redirect_to community_group_url(@group.id), notice: 'グループ「#{@group.name}」を作成しました'
        else
            render :new
        end
    end

    def show
        @group = current_user.groups.find(params[:id])
    end

    def edit
        redirect_to groups_path, notice: "作成者でないと編集できません。" unless @group.user == current_user
    end

    def update 
        if @group.update(group_params)
            redirect_to groups_path, notice: 'グループを更新しました'
        else
            render :edit
        end
    end

    def addUsers
    end

    def join
        binding.pry
        respond_to do |format|
            format.json {}
            format.html {}
        end
    end

    private

    def group_params
        params.require(:group).permit(:name, :describe)
    end

    def set_group
        @group = Group.find(params[:id])
    end

    def set_q
        @q = Group.ransack(params[:q])
    end
end



