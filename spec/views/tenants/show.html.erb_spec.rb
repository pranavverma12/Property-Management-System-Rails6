# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tenants/show', type: :view do
  it 'displays the Tenant' do
    tenant = create(:tenant)
    assign(:tenant, tenant)

    render

    expect(rendered).to include 'Tenant'

    expect(rendered).to include tenant.email
  end
end
