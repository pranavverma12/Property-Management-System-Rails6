# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  let(:landlord) { create(:landlord) }
  describe 'presence of' do
    it 'property_name' do
      expect(
        build(:property, property_name: nil).errors_on(:property_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'property_address' do
      expect(
        build(:property, property_address: nil).errors_on(:property_address)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'landlord_first_name' do
      expect(
        build(:property, landlord_first_name: nil).errors_on(:landlord_first_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'landlord_last_name' do
      expect(
        build(:property, landlord_last_name: nil).errors_on(:landlord_last_name)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'landlord_email' do
      expect(
        build(:property, landlord_email: nil).errors_on(:landlord_email)
      ).to eq [I18n.t('errors.messages.blank')]
    end
  end

  describe 'uniqueness of' do
    let(:property1) { create(:property, property_name: 'SoMePrOpErTyNaMe', landlord_email: landlord.email) }

    it 'property_name regardless of case' do
      expect(
        build(:property, property_name: property1.property_name).errors_on(:property_name)
      ).to eq [I18n.t('errors.messages.taken')]

      expect(
        build(:property, property_name: property1.property_name.upcase).errors_on(:property_name)
      ).to eq [I18n.t('errors.messages.taken')]

      expect(
        build(:property, property_name: property1.property_name.downcase).errors_on(:property_name)
      ).to eq [I18n.t('errors.messages.taken')]
    end
  end

  describe 'format of' do
    let(:landlord1) { create(:landlord, email: 'somelandlordemail@topfloor.ie') }
    let(:landlord2) { create(:landlord, email: 'somelandlordemail@topfloor.co.uk') }

    it 'landlord_email' do
      expect(
        build(:property, landlord_email: 'somelandlordemail').errors_on(:landlord_email)
      ).to eq [I18n.t('errors.messages.invalid')]

      expect(
        build(:property, landlord_email: 'topfloor.ie').errors_on(:landlord_email)
      ).to eq [I18n.t('errors.messages.invalid')]

      expect(
        build(:property, landlord_email: 'somelandlordemail @topfloor.ie').errors_on(:landlord_email)
      ).to eq [I18n.t('errors.messages.invalid')]

      expect(
        build(:property, landlord_email: 'somelandlordemail@topfloor').errors_on(:landlord_email)
      ).to eq [I18n.t('errors.messages.invalid')]
      
      expect(
        build(:property, landlord_email: landlord1.email)
      ).to be_valid

      expect(
        build(:property, landlord_email: landlord2.email)
      ).to be_valid
    end
  end

  describe 'length of' do
    email_domain_substring = '@topfloor.ie'
    max_name_length = Property::LANDLORD_EMAIL_MAX_LENGTH - email_domain_substring.length
    valid_landlord_email = "#{'a' * max_name_length}#{email_domain_substring}"
    # let(:landlord3) { create(:landlord, email: "a#{valid_landlord_email}") }
    let(:landlord4) { create(:landlord, email: valid_landlord_email) }

    it 'property_name having max of Property::PROPERTY_NAME_MAX_LENGTH' do
      expect(
        build(:property, property_name: 'a' * (Property::PROPERTY_NAME_MAX_LENGTH + 1), landlord_email: landlord.email).errors_on(:property_name)
      ).to eq [I18n.t(
        'errors.messages.too_long',
        count: Property::PROPERTY_NAME_MAX_LENGTH
      )]

      expect(
        build(:property, property_name: 'a' * Property::PROPERTY_NAME_MAX_LENGTH, landlord_email: landlord.email)
      ).to be_valid
    end

    it 'property_address having max of Property::PROPERTY_ADDRESS_MAX_LENGTH' do
      expect(
        build(:property,
              property_address: 'a' * (Property::PROPERTY_ADDRESS_MAX_LENGTH + 1), landlord_email: landlord.email).errors_on(:property_address)
      ).to eq [I18n.t(
        'errors.messages.too_long',
        count: Property::PROPERTY_ADDRESS_MAX_LENGTH
      )]

      expect(
        build(:property, property_address: 'a' * Property::PROPERTY_ADDRESS_MAX_LENGTH, landlord_email: landlord.email)
      ).to be_valid
    end

    it 'landlord_first_name having max of Property::LANDLORD_FIRST_NAME_MAX_LENGTH' do
      expect(
        build(:property,
              landlord_first_name: 'a' * (Property::LANDLORD_FIRST_NAME_MAX_LENGTH + 1), landlord_email: landlord.email).errors_on(:landlord_first_name)
      ).to eq [I18n.t(
        'errors.messages.too_long',
        count: Property::LANDLORD_FIRST_NAME_MAX_LENGTH
      )]

      expect(
        build(:property, landlord_first_name: 'a' * Property::LANDLORD_FIRST_NAME_MAX_LENGTH, landlord_email: landlord.email)
      ).to be_valid
    end

    it 'landlord_last_name having max of Property::LANDLORD_LAST_NAME_MAX_LENGTH' do
      expect(
        build(:property,
              landlord_last_name: 'a' * (Property::LANDLORD_LAST_NAME_MAX_LENGTH + 1), landlord_email: landlord.email).errors_on(:landlord_last_name)
      ).to eq [I18n.t(
        'errors.messages.too_long',
        count: Property::LANDLORD_LAST_NAME_MAX_LENGTH
      )]

      expect(
        build(:property, landlord_last_name: 'a' * Property::LANDLORD_LAST_NAME_MAX_LENGTH, landlord_email: landlord.email)
      ).to be_valid
    end

    it 'landlord_email having max of Property::LANDLORD_EMAIL_MAX_LENGTH' do      
      expect(
        build(:property, landlord_email: landlord4.email)
      ).to be_valid

      # expect(
      #   build(:property, landlord_email: landlord4.email).errors_on(:landlord_email)
      # ).to eq [I18n.t(
      #   'errors.messages.too_long',
      #   count: Property::LANDLORD_EMAIL_MAX_LENGTH
      # )]
    end
  end
end
