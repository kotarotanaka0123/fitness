require 'rails_helper'

RSpec.describe GroupsController, type: :controller do 
# 1.テスポンステスト ステータス
# 2.画面表示確認
# 3.データが作成されるか

    describe "get #join" do
        let(:group1) { FactoryBot.create(:group) }
        it "success to add current_user into group.users" do
            get :join
            expect(response).to be_success 
        end
    end

  describe "#create" do
    it "responds successfully" do
      expect { post :create, params: { task: { title: 'test1'} } }.to change(Task, :count).by(1)
    end

    it "responds successfully" do
      expect { post :create, params: { task: { title: ''} } }.not_to change(Task, :count)
    end
  end 
end