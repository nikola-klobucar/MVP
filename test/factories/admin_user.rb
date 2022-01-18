FactoryBot.define do
    factory :admin_user do
        email {"admin@admin.com"}
        password {"admin1"}
        password_confirmation {"admin1"}
    end
end