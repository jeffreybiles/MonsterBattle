FactoryGirl.define do
  factory :user do
    name "test"
    email "test@test.com"
    password "testtest"
  end

  factory :species do
    name "Grassachu"
    hp_growth 10
    attack_growth 5
    defense_growth 3
  end

  factory :monster do
    custom_name "Pika"
    level 10
    experience 50
    user
    species
  end
end