FactoryBot.define do
    factory :group do
        sequence(:name) { |n| "group#{n}" }
        sequence(:describe) { |n| "グループ#{n}です。" }
    end
end