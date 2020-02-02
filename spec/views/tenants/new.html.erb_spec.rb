# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tenants/new', type: :view do
  context 'without validation errors' do
    it 'displays new Tenant form' do
      assign(:tenant, Tenant.new)

      render

      expect(rendered).to include 'New Tenant'

      expect(rendered).to match(
        have_css('form[action="/tenants"] input[name="tenant[first_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/tenants"] input[name="tenant[last_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/tenants"] input[name="tenant[email]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/tenants"] button[type="submit"]')
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    it 'displays new Property form with error messages' do
      tenant = build(:tenant, first_name: nil)
      tenant.validate

      assign(:tenant, tenant)

      render

      expect(rendered).to include 'New Tenant'

      expect(rendered).to match(
        have_css('form[action="/tenants"] input[name="tenant[first_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/tenants"] input[name="tenant[last_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/tenants"] input[name="tenant[email]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/tenants"] button[type="submit"]')
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
