# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:params) { {} }

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params, session: session }
    
    let!(:property) { create(:property, landlord_email: landlord.email) }
    let(:params) { { id: property.id } }

    it 'destroys the Property' do
      expect { subject }.to change(Property, :count).by(-1)
      expect { property.reload }.to raise_error ActiveRecord::RecordNotFound
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
