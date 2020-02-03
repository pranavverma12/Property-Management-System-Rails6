# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    sequence(:property_name) { |i| "Some Property Name #{i}" }
    property_address { 'Some Property Address' }
    landlord_first_name { 'Some Landlord Address' }
    landlord_last_name { 'Some Landlord Last Name' }
    sequence(:landlord_email) { |i| "somelandlordemail#{i}@topfloor.ie" }
    tenancy_start_date {"02/02/2020".to_date}
    tenancy_monthly_rent {1500}
    tenancy_security_deposit {3000}
    rented {true}
    tenant_id {1}
  end
end
