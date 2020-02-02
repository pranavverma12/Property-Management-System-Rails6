# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'properties/show', type: :view do
  let(:landlord) { create(:landlord) }

  it 'displays the Property' do
    property = create(:property, landlord_email: landlord.email)
    assign(:property, property)

    render

    expect(rendered).to include 'Property'

    expect(rendered).to include property.property_name
  end
end
