FactoryBot.define do
    factory :product do
        name {"MyString"}
        product_code {(0...8).map { (65 + rand(26)).chr }.join}
        currency {"EUR"}
        price {100}
        admin_user
    end
end