# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landlords/show', type: :view do
  it 'displays the Landlord' do
    landlord = create(:landlord)
    assign(:landlord, landlord)

    render

    expect(rendered).to include 'Landlord'

    expect(rendered).to include landlord.email
    expect(rendered).to include landlord.first_name
    expect(rendered).to include landlord.last_name
  end
end
