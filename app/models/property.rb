# frozen_string_literal: true

class Property < ApplicationRecord
  attr_accessor :landlord_id

  PROPERTY_NAME_MAX_LENGTH = 100
  PROPERTY_ADDRESS_MAX_LENGTH = 500
  LANDLORD_FIRST_NAME_MAX_LENGTH = 100
  LANDLORD_LAST_NAME_MAX_LENGTH = 100
  LANDLORD_EMAIL_MAX_LENGTH = 200

  # rubocop:disable Layout/LineLength
  LANDLORD_EMAIL_REGEX = /\A([a-z0-9\+_\-\']+)(\.[a-z0-9\+_\-\']+)*@([a-z0-9\-]+\.)+[a-z]{2,6}\z/ix.freeze
  # rubocop:enable Layout/LineLength

  validates :property_name, presence: true
  validates :property_name, uniqueness: { case_sensitive: false }
  validates :property_name, length: { maximum: PROPERTY_NAME_MAX_LENGTH,
                                      if: :property_name }
  validates :property_address, presence: true
  validates :property_address, length: { maximum: PROPERTY_ADDRESS_MAX_LENGTH,
                                         if: :property_address }

  validates_presence_of :tenancy_monthly_rent, :tenancy_security_deposit

  has_many :property_tenants
  has_many :tenants, through: :property_tenants

  has_many :property_landlords
  has_many :landlords, through: :property_landlords
end
