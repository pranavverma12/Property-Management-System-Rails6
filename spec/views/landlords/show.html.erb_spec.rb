# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landlords/show', type: :view do
  it 'displays the Landlord' do
    landlord = create(:landlord)
    assign(:landlord, landlord)

    render

    expect(rendered).to include 'Landlord'

    expect(rendered).to include landlord.email
  end
end
