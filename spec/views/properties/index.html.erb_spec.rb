# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'properties/index', type: :view do
  let(:landlord) { create(:landlord) }

  it 'displays all Properties' do
    properties = create_list(:property, 2, landlord_email: landlord.email)
    assign(:properties, properties)

    render

    expect(rendered).to include 'Properties'

    properties.each do |property|
      expect(rendered).to include property.property_name
      expect(rendered).to include property.property_address
      expect(rendered).to include property.landlord_email
      expect(rendered).to include property.landlords.full_name
      expect(rendered).to include property.tenancy_security_deposit.to_s
      expect(rendered).to include property.tenancy_monthly_rent.to_s
      expect(rendered).to include property.rented.to_s
    end
  end
end
