# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:params) { {} }

  describe 'POST #create' do
    subject { post :create, params: params, session: session }

    context 'when valid tenant param attributes' do
      let(:valid_property_attributes) do
        {
          property_name: 'somepropertyname',
          property_address: 'somepropertyaddress',
          landlord_first_name: landlord.first_name,
          landlord_last_name: landlord.last_name,
          landlord_email: landlord.email
        }
      end
      let(:params) { { property: valid_property_attributes } }

      it 'assigns @property' do
        subject
        expect(assigns(:property)).to be_a Property
      end

      it 'creates a Property' do
        expect { subject }.to change(Property, :count).by(1)

        property = Property.last

        expect(property.property_name).to eq valid_property_attributes[:property_name]
        expect(property.property_address).to eq valid_property_attributes[:property_address]
        expect(property.landlord_first_name).to eq valid_property_attributes[:landlord_first_name]
        expect(property.landlord_last_name).to eq valid_property_attributes[:landlord_last_name]
        expect(property.landlord_email).to eq valid_property_attributes[:landlord_email]
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
        expect(flash[:success]).to eq 'Property was successfully created.'
      end
    end

    context 'when valid property param attributes' do
      let(:tenant) {create(:tenant)}
      let(:valid_property_attributes) do
        {
          property_name: 'somepropertyname',
          property_address: 'somepropertyaddress',
          landlord_first_name: landlord.first_name,
          landlord_last_name: landlord.last_name,
          landlord_email: landlord.email,
          tenants_emails: tenant.email,
          rented: true,
          tenancy_security_deposit: 1500,
          tenancy_monthly_rent: 1500,
          tenancy_start_date: '07/02/2020'

        }
      end
      let(:params) { { property: valid_property_attributes } }

      it 'assigns @property' do
        subject
        expect(assigns(:property)).to be_a Property
      end

      it 'creates a Property' do
        expect { subject }.to change(Property, :count).by(1)

        property = Property.last

        expect(property.property_name).to eq valid_property_attributes[:property_name]
        expect(property.property_address).to eq valid_property_attributes[:property_address]
        expect(property.landlord_first_name).to eq valid_property_attributes[:landlord_first_name]
        expect(property.landlord_last_name).to eq valid_property_attributes[:landlord_last_name]
        expect(property.landlord_email).to eq valid_property_attributes[:landlord_email]
        expect(property.tenancy_security_deposit).to eq valid_property_attributes[:tenancy_security_deposit]
        expect(property.tenancy_monthly_rent).to eq valid_property_attributes[:tenancy_monthly_rent]
        expect(property.rented).to eq valid_property_attributes[:rented]
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
        expect(flash[:success]).to eq 'Property was successfully created.'
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
      let(:params) { { property: invalid_property_attributes } }

      it 'does not create a Property' do
        expect { subject }.to_not change(Property, :count)
      end

      it 'responds with unprocessable_entity' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when incomplete tenancy attributes passed' do
      let(:tenant) { create(:tenant) }
      let(:invalid_tenancy_attributes) do
        {
          tenants_emails: tenant.email,
          tenancy_monthly_rent: '',
          tenancy_start_date: '',
          tenancy_security_deposit: ''
        }
      end
      let(:params) { { property: invalid_tenancy_attributes } }

      it 'does not create a Property' do
        expect { subject }.to_not change(Property, :count)
      end

      it 'responds with unprocessable_entity' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not logged in' do
      subject { post :create, params: params, session: {} }

      it 'returns http forbidden status' do
        subject
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders error page' do
        subject
        expect(response).to render_template('errors/not_authorized')
      end
    end

    context 'when valid multiple landlords param attributes' do
      let(:landlord1) {create(:landlord)}
      let(:landlord2) {create(:landlord)}

      let(:valid_property_attributes) do
        {
          property_name: 'somepropertyname',
          property_address: 'somepropertyaddress',
          landlord_first_name: landlord.first_name,
          landlord_last_name: landlord.last_name,
          landlord_email: landlord.email,
          multiple_landlords: true,
          other_landlords_emails: landlord1.email.to_s + ',' + landlord2.email.to_s
        }
      end
      let(:params) { { property: valid_property_attributes } }

      it 'assigns @property' do
        subject
        expect(assigns(:property)).to be_a Property
      end

      it 'creates a Property' do
        expect { subject }.to change(Property, :count).by(1)

        property = Property.last

        expect(property.property_name).to eq valid_property_attributes[:property_name]
        expect(property.property_address).to eq valid_property_attributes[:property_address]
        expect(property.landlord_first_name).to eq valid_property_attributes[:landlord_first_name]
        expect(property.landlord_last_name).to eq valid_property_attributes[:landlord_last_name]
        expect(property.landlord_email).to eq valid_property_attributes[:landlord_email]
        expect(property.other_landlords_emails).to eq valid_property_attributes[:other_landlords_emails]
        expect(property.multiple_landlords).to eq valid_property_attributes[:multiple_landlords]
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
        expect(flash[:success]).to eq 'Property was successfully created.'
      end
    end
  end
end
