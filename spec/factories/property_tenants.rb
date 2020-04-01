# frozen_string_literal: true

FactoryBot.define do
  factory :property_tenant do
    property { 1 }
    tenant { 1 }
  end
end
