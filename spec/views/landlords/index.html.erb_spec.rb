# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landlords/index', type: :view do
  it 'renders a list of landlords' do
    landlords = create_list(:landlord, 2)
    assign(:landlords, landlords)

    render

    expect(rendered).to include 'Landlord'

    landlords.each do |landlord|
      expect(rendered).to include landlord.email
      expect(rendered).to include landlord.first_name
      expect(rendered).to include landlord.last_name
    end
  end
end
