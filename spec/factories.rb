FactoryGirl.define do
  factory :user do
    sequence(:username) { |i| "User #{i}" }
<<<<<<< HEAD
    email "john.doe@example.com"
    password "password"
    password_confirmation "password"
  end
end
=======
    email    "john.doe@example.com"
    password "password"
    password_confirmation "password"
  end
end
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
