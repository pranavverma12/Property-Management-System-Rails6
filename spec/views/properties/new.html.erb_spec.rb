# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'properties/new', type: :view do
  context 'without validation errors' do
    it 'displays new Property form' do
      assign(:property, Property.new)

      render

      expect(rendered).to include 'New Property'

      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[property_name]"]'
      expect(rendered).to match have_css 'form[action="/properties"] textarea[name="property[property_address]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[landlord_first_name]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[landlord_last_name]"]'
      expect(rendered).to match have_css 'form[action="/properties"] select[name="property[landlord_email]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[multiple_landlords]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[other_landlords_emails]"]'
      expect(rendered).to match have_css 'form[action="/properties"] select[name="property[landlords_emails][]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenancy_start_date]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenancy_security_deposit]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenants_emails]"]'
      expect(rendered).to match have_css 'form[action="/properties"] select[name="property[tenants_emails_list][]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenancy_monthly_rent]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[rented]"]'
      expect(rendered).to match have_css 'form[action="/properties"] button[type="submit"]'

    end
  end

  context 'with validation errors' do
    it 'displays new Property form with error messages' do
      property = build(:property, property_name: nil)
      property.validate

      assign(:property, property)

      render

      expect(rendered).to include 'New Property'

      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[property_name]"]'
      expect(rendered).to match have_css 'form[action="/properties"] textarea[name="property[property_address]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[landlord_first_name]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[landlord_last_name]"]'
      expect(rendered).to match have_css 'form[action="/properties"] select[name="property[landlord_email]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[multiple_landlords]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[other_landlords_emails]"]'
      expect(rendered).to match have_css 'form[action="/properties"] select[name="property[landlords_emails][]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenancy_start_date]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenancy_security_deposit]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenants_emails]"]'
      expect(rendered).to match have_css 'form[action="/properties"] select[name="property[tenants_emails_list][]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[tenancy_monthly_rent]"]'
      expect(rendered).to match have_css 'form[action="/properties"] input[name="property[rented]"]'
      expect(rendered).to match have_css 'form[action="/properties"] button[type="submit"]'

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
