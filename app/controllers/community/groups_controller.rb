class Community::GroupsController < CommunityController
    before_action :set_group, only: [:edit, :update]
    before_action :set_q, only: [:index, :search] #TODO: グループ検索機能
    protect_from_forgery

    def index
        @groups = not_joining_groups # HACK: @groupに配列で入れているが、Group::ActiveRecord_Relationの形で入れたほうが良いかも。
        @users = User.where.not(id: current_user.id)
        @invited_groups = current_user.invited_groups
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

    def userlist
        # NOTE: グループに既に加入しているユーザは表示しない
        searched_users = User.where('name like ?', "#{params[:usernames]}%")
        @group = Group.find(params[:group_id])
        user_ids = (searched_users - @group.users).map(&:id)
        @users = User.where(id: user_ids)
        respond_to do |format|
            format.js {
                render json: {
                    html_data: render_to_string(partial: 'userlist', local: [@users, @group]),
                    group_id: @group.id
                }
            }
        end
    end

    def inviteUsers
        respond_to do |format|
            format.js {
                @user = User.find_by(name: params[:invite_user])
                render json: { 
                    html_data: render_to_string(partial: "checked_user", local: @user),
                    group_id: params[:group_id] 
                }
            }
        end
    end

    def create_inviteUsers
        params[:userlist].each do |user_id|
            AddUserToGroup.create(user_id: user_id, group_id: params[:group_id])
        end
    end

    def join
        @group = Group.find(params[:id])

        respond_to do |format|
        format.html{ 
            @group.users << current_user
            redirect_to community_group_url(@group.id), notice: "グループ「#{@group.name}」に参加しました！" 
        }
        format.js
        end
    end

    def join_invited_group
        group = Group.find(params[:id])
        if !group.users.ids.include?(current_user.id)
            group.users << current_user
        end
        # NOTE: 招待を消す
        current_user.add_user_to_group.find_by(group_id: group.id).destroy

        render :index
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
        Group.all.order(updated_at: "DESC") - User.find(current_user.id).groups # HACK: 全ユーザから自分のユーザを引く以外の方法があるか。
    end
end



