FactoryBot.define do
  factory :doctor do
    name { "Neha Kakkar" }
    location { "Bangalore" }
    working_hours { "15,16,17" }
  end

  factory :appointment do
    date { "01/01/2099" }
    time { "15" }
    doctor factory: :doctor
    client factory: :client
    paid_amount { 500 }
  end

  factory :client do
    email { "mail@test.com" }
    currency_preference { "USD" }
  end
end