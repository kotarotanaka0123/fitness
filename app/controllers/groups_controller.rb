class GroupsController < ApplicationController
    before_action :set_group, only: [:edit, :update]

    def index
        @groups = Group.all
    end

    def new
        @group = Group.new
        @group.users << current_user
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            redirect_to groups_path, notice: 'グループを作成しました'
        else
            render :new
        end
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
    
    private

    def group_params
        params.require(:group).permit(:name, user_ids: []).merge(user_id: current_user.id)
    end

    def set_group
        @group = Group.find(params[:id])
    end
end
