FactoryBot.define do
  factory :landlord do
    first_name { 'MyString' }
    last_name { 'MyString' }
    sequence(:email) { |i| "sometenantemail#{i}@topfloor.ie" }
  end
end
