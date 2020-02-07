# frozen_string_literal: true

class Property < ApplicationRecord
  attr_accessor :tenant_email

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
  validates :landlord_first_name, presence: true
  validates :landlord_first_name, length: {
    maximum: LANDLORD_FIRST_NAME_MAX_LENGTH, if: :landlord_first_name
  }
  validates :landlord_last_name, presence: true
  validates :landlord_last_name, length: {
    maximum: LANDLORD_LAST_NAME_MAX_LENGTH, if: :landlord_last_name
  }
  validates :landlord_email, presence: true
  validates :landlord_email, length: { maximum: LANDLORD_EMAIL_MAX_LENGTH,
                                       if: :landlord_email }
  validates :landlord_email, format: { with: LANDLORD_EMAIL_REGEX },
                            if: -> { errors[:landlord_email].blank? }

  belongs_to :landlords, :class_name => 'Landlord',
                        primary_key: :email,
                        foreign_key: :landlord_email

  has_many :tenants, :class_name => 'Tenant', foreign_key: :property_id

  scope :other_landlords, ->(emails) {Landlord.where("email IN (?)", emails)}
end
