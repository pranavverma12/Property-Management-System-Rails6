# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenantsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'PUT #update' do
    subject { put :update, params: params, session: session }

    let!(:tenant) { create(:tenant) }
    let(:params) { { id: tenant.id } }

    context 'when valid tenant param attributes' do
      let(:valid_attributes) { { 'first_name' => build(:tenant).first_name } }
      let(:params) { { id: tenant.id, tenant: { first_name: valid_attributes['first_name'] } } }

      it 'assigns @tenant' do
        subject
        expect(assigns(:tenant)).to be_a Tenant
      end

      it 'updates the Tenant' do
        subject

        tenant.reload
        expect(tenant.first_name).to eq valid_attributes['first_name']
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to properties#show' do
        subject
        expect(response).to redirect_to Tenant.last
      end

      it 'assigns flash success' do
        subject
        expect(flash[:success]).to eq I18n.t(:success_update,
                                             scope: 'controllers.tenants.messages',
                                             first_name: valid_attributes['first_name'],
                                             last_name: tenant.last_name)
      end
    end

    context 'when invalid tenant param attributes' do
      let(:invalid_attributes) { { 'first_name' => '' } }
      let(:params) { { id: tenant.id, tenant: invalid_attributes } }

      it 'does not update the tenant' do
        expect { subject }.to_not(change { tenant.reload.attributes })
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
