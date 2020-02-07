# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'presence of' do
    it 'username' do
      expect(
        build(:user, username: nil).errors_on(:username)
      ).to eq [I18n.t('errors.messages.blank')]
    end
  end

  describe 'must be unique' do
    let(:user1) { create(:user) }

    it 'username regardless of case' do
      expect(
        build(:user, username: user1.username).errors_on(:username)
      ).to eq [I18n.t('errors.messages.taken')]

      expect(
        build(:user, username: user1.username.upcase).errors_on(:username)
      ).to eq [I18n.t('errors.messages.taken')]

      expect(
        build(:user, username: user1.username.downcase).errors_on(:username)
      ).to eq [I18n.t('errors.messages.taken')]
    end
  end

  describe 'format of' do
    describe 'username' do
      it 'can only contain a-z and 0-9 characters' do
        expect(
          build(:user, username: 'abc-efg').errors_on(:username)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:user, username: 'abc_83729').errors_on(:username)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(build(:user, username: 'abcdefg')).to be_valid

        expect(build(:user, username: 'abcdefg1234')).to be_valid

        expect(build(:user, username: '1234abcdefg')).to be_valid
      end

      it 'maximum length of User::USERNAME_MAX_LENGTH' do
        expect(
          build(:user, username: 'a' * (User::USERNAME_MAX_LENGTH + 1)).errors_on(:username)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: User::USERNAME_MAX_LENGTH
        )]

        expect(
          build(:user, username: 'a' * User::USERNAME_MIN_LENGTH)
        ).to be_valid
      end

      it 'minimum length of User::USERNAME_MIN_LENGTH' do
        expect(
          build(:user, username: 'a' * (User::USERNAME_MIN_LENGTH - 1)).errors_on(:username)
        ).to eq [I18n.t(
          'errors.messages.too_short',
          count: User::USERNAME_MIN_LENGTH
        )]

        expect(
          build(:user, username: 'a' * User::USERNAME_MIN_LENGTH)
        ).to be_valid
      end

      it 'connot contain new line characters' do
        expect(
          build(:user, username: "my\nuserame").errors_on(:username)
        ).to eq [I18n.t('errors.messages.too_many_lines', count: 1)]
      end

      it 'connot contain new space characters' do
        expect(
          build(:user, username: 'my user name').errors_on(:username)
        ).to eq [I18n.t('errors.messages.no_spaces')]
      end

      it 'is auto-downcased' do
        s = 'ABCDEFGHIJK'
        user = create(:user, username: s)
        expect(user.username).to eq s.downcase
      end
    end

    describe 'password' do
      it 'minimum length of User::PASSWORD_MIN_LENGTH' do
        expect(
          build(:user, password: 'a' * (User::PASSWORD_MIN_LENGTH - 1)).errors_on(:password)
        ).to eq [I18n.t(
          'errors.messages.too_short',
          count: User::PASSWORD_MIN_LENGTH
        )]

        expect(
          build(:user, password: 'a' * User::PASSWORD_MIN_LENGTH)
        ).to be_valid
      end

      it 'connot contain new space characters' do
        expect(
          build(:user, password: 'my very long secure password').errors_on(:password)
        ).to eq [I18n.t('errors.messages.no_spaces')]
      end

      it 'connot contain new line characters' do
        expect(
          build(:user, password: "my\nverylongsecurepassword").errors_on(:password)
        ).to eq [I18n.t('errors.messages.too_many_lines', count: 1)]
      end
    end
  end

  describe 'whitespace trimmed' do
    it 'username' do
      s = ' 123ab '
      user = create(:user, username: s)
      expect(user.username).to eq s.strip
    end
  end
end
