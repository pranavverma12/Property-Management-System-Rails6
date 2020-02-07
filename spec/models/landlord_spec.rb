# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Landlord, type: :model do
  describe 'presence of' do
    it 'first_name' do
      expect(
        build(:landlord, first_name: nil).errors_on(:first_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'last_name' do
      expect(
        build(:landlord, last_name: nil).errors_on(:last_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'email' do
      expect(
        build(:landlord, email: nil).errors_on(:email)
      ).to eq [I18n.t('errors.messages.blank')]
    end
  end

  describe 'format of' do
    describe 'email' do
      it 'valid email format' do
        expect(
          build(:landlord, email: 'somelandlordemail').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:landlord, email: 'topfloor.ie').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:landlord, email: 'somelandlordemail @topfloor.ie').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:landlord, email: 'somelandlordemail@topfloor').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:landlord, email: 'somelandlordemail@topfloor.ie')
        ).to be_valid

        expect(
          build(:landlord, email: 'somelandlordemail@topfloor.co.uk')
        ).to be_valid
      end

      it 'max length of Landlord::EMAIL_MAX_LENGTH' do
        email_domain_substring = '@topfloor.ie'
        max_name_length = Landlord::EMAIL_MAX_LENGTH - email_domain_substring.length
        invalid_email = "#{'aa' * max_name_length}#{email_domain_substring}"
        valid_email = "#{'a' * max_name_length}#{email_domain_substring}"

        expect(
          build(:landlord, email: invalid_email).errors_on(:email)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: Landlord::EMAIL_MAX_LENGTH
        )]

        expect(
          build(:landlord, email: valid_email)
        ).to be_valid
      end

      it 'is auto-downcased' do
        s = 'ABCDEFGHIJK@topfloor.ie'
        landlord = create(:landlord, email: s)
        expect(landlord.email).to eq s.downcase
      end
    end

    describe 'uniqueness of' do
      let(:landlord) { create(:landlord) }

      it 'email regardless of case' do
        expect(
          build(:landlord, email: landlord.email).errors_on(:email)
        ).to eq [I18n.t('errors.messages.taken')]

        expect(
          build(:landlord, email: landlord.email.upcase).errors_on(:email)
        ).to eq [I18n.t('errors.messages.taken')]

        expect(
          build(:landlord, email: landlord.email.downcase).errors_on(:email)
        ).to eq [I18n.t('errors.messages.taken')]
      end
    end

    describe 'first_name' do
      it 'max length of Landlord::FIRST_NAME_MAX_LENGTH' do
        expect(
          build(:landlord, first_name: 'a' * (Landlord::FIRST_NAME_MAX_LENGTH + 1)).errors_on(:first_name)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: Landlord::FIRST_NAME_MAX_LENGTH
        )]

        expect(
          build(:landlord, first_name: 'a' * Landlord::FIRST_NAME_MAX_LENGTH)
        ).to be_valid
      end

      it 'connot contain new line characters' do
        expect(
          build(:landlord, first_name: "my\nfirst_name").errors_on(:first_name)
        ).to eq [I18n.t('errors.messages.too_many_lines', count: 1)]
      end
    end

    describe 'last_name' do
      it 'max length of Landlord::LAST_NAME_MAX_LENGTH' do
        expect(
          build(:landlord, last_name: 'a' * (Landlord::LAST_NAME_MAX_LENGTH + 1)).errors_on(:last_name)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: Landlord::LAST_NAME_MAX_LENGTH
        )]

        expect(
          build(:landlord, last_name: 'a' * Landlord::LAST_NAME_MAX_LENGTH)
        ).to be_valid
      end

      it 'connot contain new line characters' do
        expect(
          build(:landlord, last_name: "my\nlast_name").errors_on(:last_name)
        ).to eq [I18n.t('errors.messages.too_many_lines', count: 1)]
      end
    end
  end

  describe 'whitespace trimmed' do
    it 'email' do
      s = ' 123ab@topfloor.ie '
      landlord = create(:landlord, email: s)
      expect(landlord.email).to eq s.strip
    end

    it 'first_name' do
      s = ' 123ab '
      landlord = create(:landlord, first_name: s)
      expect(landlord.first_name).to eq s.strip
    end

    it 'last_name' do
      s = ' 123ab '
      landlord = create(:landlord, last_name: s)
      expect(landlord.last_name).to eq s.strip
    end
  end
end
