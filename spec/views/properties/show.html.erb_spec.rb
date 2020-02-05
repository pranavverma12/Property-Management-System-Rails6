# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'properties/show', type: :view do
  let(:landlord) { create(:landlord) }
  let(:tenant) { create(:tenant) }

  it 'displays the Property' do
    property = create(:property, landlord_email: landlord.email, tenant_id: tenant.id)
    tenant.update(property_id: property.id)
    assign(:property, property)

    render
    
    expect(rendered).to include 'Property'
    expect(rendered).to include property.property_name
    expect(rendered).to include property.property_address
    expect(rendered).to include property.landlords.email
    expect(rendered).to include property.landlords.first_name
    expect(rendered).to include property.landlords.last_name
    expect(rendered).to include property.tenants.first.email
    expect(rendered).to include property.tenancy_security_deposit.to_s
    expect(rendered).to include property.tenancy_monthly_rent.to_s
  end
end
