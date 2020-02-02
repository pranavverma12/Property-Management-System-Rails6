# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:tenant) { create(:tenant) }
  let(:params) { {} }

  describe 'PUT #update' do
    subject { put :update, params: params, session: session }

    let!(:property) { create(:property, landlord_email: landlord.email) }
    let(:params) { { id: property.id } }

    context 'when valid property param attributes' do
      let(:valid_property_attributes) do
        {
          property_name: 'somepropertyname',
          property_address: 'somepropertyaddress',
          landlord_first_name: landlord.first_name,
          landlord_last_name: landlord.last_name,
          landlord_email: landlord.email,
          tenancy_start_date: "02/02/2020".to_date,
          tenancy_monthly_rent: 1500,
          tenancy_security_deposit: 3000,
          tenant_id: 1
        }
      end
      let(:params) { { id: property.id, property: valid_property_attributes } }

      it 'assigns @property' do
        tenant.reload
        subject
        expect(assigns(:property)).to be_a Property
      end

      it 'updates the Property' do
        tenant.reload
        subject
        property.reload
        expect(property.property_name).to eq valid_property_attributes[:property_name]
        expect(property.property_address).to eq valid_property_attributes[:property_address]
        expect(property.landlord_first_name).to eq valid_property_attributes[:landlord_first_name]
        expect(property.landlord_last_name).to eq valid_property_attributes[:landlord_last_name]
        expect(property.landlord_email).to eq valid_property_attributes[:landlord_email]
        expect(property.tenancy_start_date).to eq valid_property_attributes[:tenancy_start_date]
        expect(property.tenancy_monthly_rent).to eq valid_property_attributes[:tenancy_monthly_rent]
        expect(property.tenancy_security_deposit).to eq valid_property_attributes[:tenancy_security_deposit]
        expect(property.tenant_id).to eq valid_property_attributes[:tenant_id]
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to properties#show' do
        subject
        expect(response).to redirect_to Property.last
      end

      it 'assigns flash success' do
        subject
        expect(flash[:success]).to eq 'Property was successfully updated.'
      end
    end

    context 'when invalid property param attributes' do
      let(:invalid_property_attributes) do
        {
          property_name: '',
          property_address: '',
          landlord_first_name: '',
          landlord_last_name: '',
          landlord_email: ''
        }
      end
      let(:params) { { id: property.id, property: invalid_property_attributes } }

      it 'does not update the Property' do
        expect { subject }.to_not(change { property.reload.attributes })
      end

      it 'responds with unprocessable_entity' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not logged in' do
      subject { put :update, params: params, session: {} }

      it 'returns http forbidden status' do
        subject
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders error page' do
        subject
        expect(response).to render_template('errors/not_authorized')
      end
    end
  end
end
