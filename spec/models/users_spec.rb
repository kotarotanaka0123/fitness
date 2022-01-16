require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
    describe 'バリデーション' do
        context '必要なカラムが揃っている場合' do  #context: 条件, it: 期待する結果
            user = User.new(email: "example@example.com", password: "password", name: "kotaro")
            it '保存できる' do
                expect(user).to be_valid
            end
        end
        context '必要なカラムが揃っていない場合' do
            user = User.new
            it '保存できない' do
                expect(user).not_to be_valid
            end
        end
        describe '重複' do
            context 'ある場合' do
                it '保存できる' do
                end
            end
            context 'ない場合' do
                it '保存できない' do
                end
            end
        end
    end

    describe '#already_liked?' do
        context 'いいねがある場合' do
            let(:user1) { FactoryBot.create(:user, name: 'user1', confirmed_at: Time.now)}
            let(:user2) { FactoryBot.create(:user, name: 'user2', confirmed_at: Time.now)}
            let(:message) {FactoryBot.create(:message, user: user2)}
            before do
                user1.likes.create(message: message)
            end
            it 'いいね済みである' do
                expect(user1.already_liked?(message)).to eq true
            end
        end
        context 'いいねがない場合' do
            user1 = User.create(email: "example1@example.com", password: "password1", name: "user1", confirmed_at: Time.now)
            user2 = User.create(email: "example2@example.com", password: "password2", name: "user2", confirmed_at: Time.now)
            message = Message.create(user: user1, content: "user1")
            it 'いいねがない' do
                expect(user1.already_liked?(message)).to eq false
            end
        end
    end
end