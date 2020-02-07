# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "MyString#{i}" }
    password { 'MyBigLongPasswordDigest' }
    password_confirmation { password }
  end
end
