# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'properties/edit', type: :view do
  let(:landlord) { create(:landlord) }

  context 'without validation errors' do
    it 'displays edit Property form' do
      property = create(:property, landlord_email: landlord.email)
      assign(:property, property)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[property_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] textarea[name=\"property[property_address]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[landlord_first_name]\"]")
      )
      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[landlord_last_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] select[name=\"property[landlord_email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[tenancy_start_date]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[tenancy_monthly_rent]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[tenancy_security_deposit]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] select[name=\"property[tenant_email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[rented]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    it 'displays edit Property form with error messages' do
      property = create(:property, landlord_email: landlord.email)
      property.property_name = nil
      property.validate

      assign(:property, property)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[property_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] textarea[name=\"property[property_address]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[landlord_first_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[landlord_last_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] select[name=\"property[landlord_email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[tenancy_start_date]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[tenancy_monthly_rent]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[tenancy_security_deposit]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] select[name=\"property[tenant_email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] input[name=\"property[rented]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/properties/#{property.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
