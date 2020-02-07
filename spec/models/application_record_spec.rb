# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  let(:landlord) { create(:landlord) }
  let(:tenant) { create(:tenant) }

  describe 'Checking correct full name of' do
    it 'Landlord' do
      expect(landlord.full_name).to eq landlord.first_name.capitalize + ' ' + landlord.last_name.capitalize
    end

    it 'Tenant' do
      expect(tenant.full_name).to eq tenant.first_name.capitalize + ' ' + tenant.last_name.capitalize
    end
  end
  
end
