# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landlords/new', type: :view do
  context 'without validation errors' do
    it 'displays new Landlord form' do
      assign(:landlord, Landlord.new)

      render

      expect(rendered).to include 'New Landlord'

      expect(rendered).to match(
        have_css('form[action="/landlords"] input[name="landlord[first_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/landlords"] input[name="landlord[last_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/landlords"] input[name="landlord[email]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/landlords"] button[type="submit"]')
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    it 'displays new Property form with error messages' do
      landlord = build(:landlord, first_name: nil)
      landlord.validate

      assign(:landlord, landlord)

      render

      expect(rendered).to include 'New Landlord'

      expect(rendered).to match(
        have_css('form[action="/landlords"] input[name="landlord[first_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/landlords"] input[name="landlord[last_name]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/landlords"] input[name="landlord[email]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/landlords"] button[type="submit"]')
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
