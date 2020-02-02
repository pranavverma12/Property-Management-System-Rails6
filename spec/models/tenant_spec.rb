# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe 'presence of' do
    it 'first_name' do
      expect(
        build(:tenant, first_name: nil).errors_on(:first_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'last_name' do
      expect(
        build(:tenant, last_name: nil).errors_on(:last_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'email' do
      expect(
        build(:tenant, email: nil).errors_on(:email)
      ).to eq [I18n.t('errors.messages.blank')]
    end
  end

  describe 'format of' do
    describe 'email' do
      it 'valid email format' do
        expect(
          build(:tenant, email: 'somelandlordemail').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:tenant, email: 'topfloor.ie').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:tenant, email: 'somelandlordemail @topfloor.ie').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:tenant, email: 'somelandlordemail@topfloor').errors_on(:email)
        ).to eq [I18n.t('errors.messages.invalid')]

        expect(
          build(:tenant, email: 'somelandlordemail@topfloor.ie')
        ).to be_valid

        expect(
          build(:tenant, email: 'somelandlordemail@topfloor.co.uk')
        ).to be_valid
      end

      it 'max length of Tenant::EMAIL_MAX_LENGTH' do
        email_domain_substring = '@topfloor.ie'
        max_name_length = Tenant::EMAIL_MAX_LENGTH - email_domain_substring.length
        invalid_email = "#{'aa' * max_name_length}#{email_domain_substring}"
        valid_email = "#{'a' * max_name_length}#{email_domain_substring}"

        expect(
          build(:tenant, email: invalid_email).errors_on(:email)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: Tenant::EMAIL_MAX_LENGTH
        )]

        expect(
          build(:tenant, email: valid_email)
        ).to be_valid
      end

      it 'is auto-downcased' do
        s = 'ABCDEFGHIJK@topfloor.ie'
        tenant = create(:tenant, email: s)
        expect(tenant.email).to eq s.downcase
      end
    end

    describe 'first_name' do
      it 'max length of Tenant::FIRST_NAME_MAX_LENGTH' do
        expect(
          build(:tenant, first_name: 'a' * (Tenant::FIRST_NAME_MAX_LENGTH + 1)).errors_on(:first_name)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: Tenant::FIRST_NAME_MAX_LENGTH
        )]

        expect(
          build(:tenant, first_name: 'a' * Tenant::FIRST_NAME_MAX_LENGTH)
        ).to be_valid
      end

      it 'connot contain new line characters' do
        expect(
          build(:tenant, first_name: "my\nfirst_name").errors_on(:first_name)
        ).to eq [I18n.t('errors.messages.too_many_lines', count: 1)]
      end
    end

    describe 'last_name' do
      it 'max length of Tenant::LAST_NAME_MAX_LENGTH' do
        expect(
          build(:tenant, last_name: 'a' * (Tenant::LAST_NAME_MAX_LENGTH + 1)).errors_on(:last_name)
        ).to eq [I18n.t(
          'errors.messages.too_long',
          count: Tenant::LAST_NAME_MAX_LENGTH
        )]

        expect(
          build(:tenant, last_name: 'a' * Tenant::LAST_NAME_MAX_LENGTH)
        ).to be_valid
      end

      it 'connot contain new line characters' do
        expect(
          build(:tenant, last_name: "my\nfirst_name").errors_on(:last_name)
        ).to eq [I18n.t('errors.messages.too_many_lines', count: 1)]
      end
    end
  end

  describe 'whitespace trimmed' do
    it 'email' do
      s = ' 123ab@topfloor.ie '
      tenant = create(:tenant, email: s)
      expect(tenant.email).to eq s.strip
    end

    it 'first_name' do
      s = ' 123ab '
      tenant = create(:tenant, first_name: s)
      expect(tenant.first_name).to eq s.strip
    end

    it 'last_name' do
      s = ' 123ab '
      tenant = create(:tenant, last_name: s)
      expect(tenant.last_name).to eq s.strip
    end
  end
end
