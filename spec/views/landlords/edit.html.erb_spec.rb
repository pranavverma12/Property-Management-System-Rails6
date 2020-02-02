# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landlords/edit', type: :view do
  context 'without validation errors' do
    it 'displays edit Landlord form' do
      landlord = create(:landlord)

      assign(:landlord, landlord)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] input[name=\"landlord[first_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] input[name=\"landlord[last_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] input[name=\"landlord[email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    it 'displays edit landlord form with error messages' do
      landlord = create(:landlord)
      landlord.first_name = nil
      landlord.validate

      assign(:landlord, landlord)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] input[name=\"landlord[first_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] input[name=\"landlord[last_name]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] input[name=\"landlord[email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/landlords/#{landlord.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
