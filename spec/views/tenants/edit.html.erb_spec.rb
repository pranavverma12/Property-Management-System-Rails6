# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tenants/edit', type: :view do
  context 'without validation errors' do
    it 'displays edit Tenant form' do
      tenant = create(:tenant)

      assign(:tenant, tenant)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] input[name=\"tenant[first_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] input[name=\"tenant[last_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] input[name=\"tenant[email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    it 'displays edit Tenant form with error messages' do
      tenant = create(:tenant)
      tenant.first_name = nil
      tenant.validate

      assign(:tenant, tenant)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] input[name=\"tenant[first_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] input[name=\"tenant[last_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] input[name=\"tenant[email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/tenants/#{tenant.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
