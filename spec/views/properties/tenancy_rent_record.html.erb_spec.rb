# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'properties/tenancy_rent_record', type: :view do
  let(:landlord) { create(:landlord) }
  let(:tenant1) { create(:tenant) }
  let(:tenant2) { create(:tenant) }
  let!(:property1) { create(:property, landlord_email: landlord.email, tenants_emails: tenant1.email, rented: true) }
  let!(:property2) { create(:property, landlord_email: landlord.email, tenants_emails: tenant2.email, rented: true) }

  it 'displays all Properties which are rented' do
    tenant1.update(property_id: property1.id)
    tenant2.update(property_id: property2.id)
    properties = [property1, property2]

    assign(:properties, properties)

    render

    expect(rendered).to include 'Tenancy Rent Record'

    properties.each do |property|
      expect(rendered).to include property.property_name
      expect(rendered).to include property.property_address
      expect(rendered).to include property.landlords.full_name
      expect(rendered).to include property.landlord_email
      expect(rendered).to include property.tenancy_monthly_rent.to_s
      expect(rendered).to include rent_due_on(property)
    end
  end
end
