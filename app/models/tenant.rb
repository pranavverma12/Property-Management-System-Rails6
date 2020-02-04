# frozen_string_literal: true

class Tenant < ApplicationRecord
  FIRST_NAME_MAX_LENGTH = 100
  LAST_NAME_MAX_LENGTH = 100
  EMAIL_MAX_LENGTH = 200

  # rubocop:disable Layout/LineLength
  EMAIL_REGEX = /\A([a-z0-9\+_\-\']+)(\.[a-z0-9\+_\-\']+)*@([a-z0-9\-]+\.)+[a-z]{2,6}\z/ix.freeze
  # rubocop:enable Layout/LineLength

  before_validation :downcase
  before_validation :strip_whitespace

  validates :email, presence: true
  validates :email, length: { maximum: EMAIL_MAX_LENGTH,
                              if: :email }
  validates :email, format: { with: EMAIL_REGEX },
                    if: -> { errors[:email].blank? }

  validates :first_name, presence: true
  validates :first_name, length: { maximum: FIRST_NAME_MAX_LENGTH,
                                   if: :first_name }
  validates :first_name, number_of_lines: { maximum: 1 },
                         if: -> { errors[:first_name].blank? }

  validates :last_name, presence: true
  validates :last_name, length: { maximum: LAST_NAME_MAX_LENGTH,
                                  if: :last_name }
  validates :last_name, number_of_lines: { maximum: 1 },
                        if: -> { errors[:last_name].blank? }

  belongs_to :property, optional: true, :class_name => 'Property', foreign_key: :property_id

  private

  def strip_whitespace
    email&.strip!
    first_name&.strip!
    last_name&.strip!
  end

  def downcase
    email&.downcase!
  end
end
