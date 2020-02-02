# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:params) { {} }

  describe 'POST #create' do
    subject { post :create, params: params, session: session }

    context 'when valid property param attributes' do
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
  end
end
