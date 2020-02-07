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
    landlords = Landlord.all    

    it 'landlords email present' do
      expect(landlords.map(&:email)).to match_array landlords_email_list
    end
  end

  describe "Retrieve tenants email from Tenants table" do

    it 'list generated' do
      tenants = Tenant.all
      expect(tenants.map(&:email)).to match_array tenants_email_list
    end
  end

  describe "Rent due on" do
    let(:landlord) {create(:landlord)}
    let(:property) {create(:property, landlord_email: landlord.email, tenancy_start_date: '02/01/2020')}

    it 'day on the current month' do 
      expect(rent_due_on(property)).to eq '02 February 2020'
    end
  end

  describe "Updating Property tenants" do
    let(:landlord) {create(:landlord)} 
    let(:tenant) {create(:tenant)}
    let(:property) {create(:property, landlord_email: landlord.email, tenants_emails: tenant.email)}
    let(:tenant1) {create(:tenant, property_id: property.id)}

    it 'updating to new tenants details' do
      tenant.update(property_id: property.id)
      expect(update_tenants_details(property, tenant1.email)).to eq true
    end
  end

  describe "Email list of other available landlords" do
    let(:landlord) {create(:landlord)}
    let(:property) {create(:property, landlord_email: landlord.email)}

    it 'expect current landlord' do
      other_landlords = Landlord.where.not(email: landlord.email)
      expect(other_landlords_email_list(property.landlord_email)).to eq other_landlords
    end
  end

  describe "Landlords details available?" do
    let(:landlord) {create(:landlord)}
    let(:landlord1) {create(:landlord)}
    let(:landlord2) {create(:landlord)}
    let(:property) {create(:property, landlord_email: landlord.email, other_landlords_emails: landlord1.email.to_s + ","+ landlord2.email.to_s)}
    let(:property2) {create(:property, landlord_email: landlord.email)}

    it 'property has multiple landlords' do
      landlords_emails = (landlord1.email.to_s + ','+ landlord2.email.to_s + ','+ landlord.email).split(',')
      expect(landlords_details(property).map(&:email)).to match_array landlords_emails
    end

    it 'property has no multiple landlords' do
      landlords_emails = [landlord.email]
      expect(landlords_details(property2).map(&:email)).to match_array landlords_emails
    end
  end
end
