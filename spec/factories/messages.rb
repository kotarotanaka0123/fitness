FactoryBot.define do
    factory :message do
        association(:user)
        content {"メッセージ"}
    end
end