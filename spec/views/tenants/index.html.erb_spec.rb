# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tenants/index', type: :view do
  it 'renders a list of tenants' do
    tenants = create_list(:tenant, 2)
    assign(:tenants, tenants)

    render

    expect(rendered).to include 'Tenants'

    tenants.each do |tenant|
      expect(rendered).to include tenant.email
    end
  end
end
