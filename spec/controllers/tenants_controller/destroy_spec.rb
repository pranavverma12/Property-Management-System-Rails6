# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenantsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params, session: session }

    let!(:tenant) { create(:tenant) }
    let(:params) { { id: tenant.id } }

    it 'destroys the tenant' do
      expect { subject }.to change(Tenant, :count).by(-1)
      expect { tenant.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    context 'when user is not logged in' do
      subject { delete :destroy, params: params, session: {} }

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
