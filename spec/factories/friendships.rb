FactoryGirl.define do
  factory :friendship do
    association :user, factory: :user
    association :friend, factory: :user
    status "MyString"
  end
end
