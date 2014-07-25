# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :league do
    name "MyString"
    manager_id 1
    number_of_teams 1
  end
end
