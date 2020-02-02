# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    sequence(:property_name) { |i| "Some Property Name #{i}" }
    property_address { 'Some Property Address' }
    landlord_first_name { 'Some Landlord Address' }
    landlord_last_name { 'Some Landlord Last Name' }
    sequence(:landlord_email) { |i| "somelandlordemail#{i}@topfloor.ie" }
  end
end
