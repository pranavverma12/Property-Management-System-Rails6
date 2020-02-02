# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PropertiesHelper. For example:

RSpec.describe PropertiesHelper, type: :helper do

  describe "Landlord table empty, retrieve landlord email from property" do
    let(:valid_property_attributes) do
      {
        property_name: 'somepropertyname',
        property_address: 'somepropertyaddress',
        landlord_first_name: "somelandlord.first_name",
        landlord_last_name: "somelandlord.last_name",
        landlord_email: "somelandlord@email.com"
      }
    end

    it 'landlords not present present' do
      landlord = Landlord.find_by(email: valid_property_attributes[:landlord_email])      
      expect(landlord).to be_nil
    end

    it 'landlord email from property' do      
      expect(valid_property_attributes[:landlord_email]).to match(Property::LANDLORD_EMAIL_REGEX)
    end
  end

  describe "Retrieve landlord email from Landlord table" do
    let!(:landlord) { create(:landlord) }      

    it 'landlords email present' do      
      expect(landlord.email).to match(Property::LANDLORD_EMAIL_REGEX)
    end
  end
end
