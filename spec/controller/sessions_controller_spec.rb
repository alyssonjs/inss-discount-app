# spec/controllers/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password123') }
  describe 'POST #create' do
    context 'with valid credentials' do      
      it 'logs the user in and redirects to the collaborator page' do
        post :create, params: { login: { email: 'user@example.com', password: 'password123' } }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to('/collaborator')
        expect(flash[:notice]).to be_nil
      end
    end

    context 'with invalid credentials' do
      it 'does not log the user in and redirects to the login page with an error message' do
        post :create, params: { login: { email: 'user@example.com', password: 'wrongpassword' } }
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq('Algo está errado, confira seu email ou senha.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs the user out and redirects to the login page' do
      # Simulate a logged-in user
      session[:user_id] = user.id

      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
      expect(flash[:notice]).to eq('Você está deslogado')
    end
  end
end
