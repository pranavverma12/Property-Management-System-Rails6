# frozen_string_literal: true

class User < ApplicationRecord
  USERNAME_MAX_LENGTH = 24
  USERNAME_MIN_LENGTH = 4

  # in a real project this should probably be at least 15
  PASSWORD_MIN_LENGTH = 10

  # there isn't really a max password...but this stops attempting to input
  # something crazy long
  PASSWORD_MAX_LENGTH = 200

  has_secure_password

  before_validation :downcase_username
  before_validation :strip_whitespace_username

  # Each validation has an if guard, as we to only show user a single, most
  # relevant validation error
  validates :username, presence: true
  validates :username, no_spaces: true, if: -> { errors[:username].blank? }
  validates :username, number_of_lines: { maximum: 1 },
                       if: -> { errors[:username].blank? }
  validates :username, format: { with: /\A[a-zA-Z0-9]*\Z/ },
                       if: -> { errors[:username].blank? }
  validates :username, length: { minimum: USERNAME_MIN_LENGTH,
                                 maximum: USERNAME_MAX_LENGTH },
                       if: -> { username }
  validates :username, uniqueness: { case_sensitive: false },
                       if: -> { errors[:username].blank? }

  validates :password, no_spaces: true,
                       if: -> { password && errors[:password].blank? }
  validates :password, number_of_lines: { maximum: 1 },
                       if: -> { password && errors[:password].blank? }
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH,
                                 maximum: PASSWORD_MAX_LENGTH },
                       if: -> { password && errors[:password].blank? }

  private

  def downcase_username
    username&.downcase!
  end

  def strip_whitespace_username
    username&.strip!
  end
end
