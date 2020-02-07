# frozen_string_literal: true

FactoryBot.define do
  factory :tenant do
    first_name { 'MyString' }
    last_name { 'MyString' }
    sequence(:email) { |i| "sometenantemail#{i}@topfloor.ie" }
    property_id {1}
  end
end
