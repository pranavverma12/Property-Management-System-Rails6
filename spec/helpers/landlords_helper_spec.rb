# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LandlordsHelper.

RSpec.describe LandlordsHelper, type: :helper do

  describe 'PUT #update' do

    context 'landlord attributes updated' do
      let(:landlord) { create(:landlord, email: 'somelandlordemail1@topfloor.ie') }

      it "landlord has no properties" do                
        expect(landlord.properties).to be_empty
      end

      let(:property) { create(:property, landlord_email: landlord.email) }

      it "landlord properties exist" do
        property.reload
        expect(landlord.properties).not_to be_nil
      end

      it "landlord updated, updating properties details" do
        landlord.reload #loading landlord details
        property.reload #loading property details

        landlord_properties = landlord.properties.first #retrieving the properties list associated with the previous email 'somelandlordemail1@topfloor.ie'
        
        landlord_updated = landlord.update(first_name: "testcasefn", last_name: "testcaseln", email: 'somelandlordemail2@topfloor.ie') #updating the landlord details
        
        expect(landlord_updated).to be(true)

        status = landlord_properties.update!(landlord_first_name: landlord.first_name, landlord_last_name: landlord.last_name, landlord_email: landlord.email) #updating the associated properties details
 
        expect(status).to be(true)
        expect(landlord_properties.landlord_email).to eq(landlord.email)
        expect(landlord_properties.landlord_first_name).to eq(landlord.first_name)
        expect(landlord_properties.landlord_last_name).to eq(landlord.last_name)
      end
    end
  end
end
