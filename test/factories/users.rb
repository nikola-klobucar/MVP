FactoryBot.define do
    factory :user do
        email {"nikola@bar.com"}
        password {"password"}
        password_confirmation {"password"}
    end
end