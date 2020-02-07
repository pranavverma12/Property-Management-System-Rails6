# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LandlordsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'PUT #update' do
    subject { put :update, params: params, session: session }

    let!(:landlord) { create(:landlord) }
    let(:property) { create(:property, landlord_email: landlord.email) }
    let(:params) { { id: landlord.id } }

    context 'when valid landlord param attributes' do
      let(:valid_landlord_attributes) do
        {
          first_name: 'somelandlordfirstname',
          last_name: 'somelandlordlastname',
          email: 'somelandlordemail@topfloor.ie'
        }
      end
      let(:params) { { id: landlord.id, landlord: valid_landlord_attributes } }

      it 'assigns @landlord' do
        subject
        expect(assigns(:landlord)).to be_a Landlord
      end

      it 'updates the Landlord' do
        subject

        landlord.reload
        property.reload
        
        expect(landlord.first_name).to eq valid_landlord_attributes[:first_name]
        expect(landlord.last_name).to eq valid_landlord_attributes[:last_name]
        expect(landlord.email).to eq valid_landlord_attributes[:email]
        expect(landlord.email).to eq property.landlord_email
        expect(landlord.try(:properties).count).to eq 1
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to landlords#show' do
        subject
        expect(response).to redirect_to Landlord.last
      end

      it 'assigns flash success' do
        subject
        expect(flash[:success]).to eq I18n.t(:success_update,
                                             scope: 'controllers.landlords.messages',
                                             first_name: valid_landlord_attributes[:first_name],
                                             last_name: valid_landlord_attributes[:last_name],
                                             email: valid_landlord_attributes[:email])
      end
    end

    context 'when invalid landlord param attributes' do
      let(:invalid_landlord_attributes) do
        {
          first_name: '',
          last_name: '',
          email: ''
        }
      end
      let(:params) { { id: landlord.id, landlord: invalid_landlord_attributes } }

      it 'does not update the Landlord' do
        expect { subject }.to_not(change { landlord.reload.attributes })
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
