require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      User.create!(valid_attributes)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = User.create!(valid_attributes)
      get :show, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      user = User.create!(valid_attributes)
      get :edit, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Updated Name',
          password: 'password',
        }
      end

      it 'updates the requested user' do
        user = User.create!(valid_attributes)
        patch :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.name).to eq('Updated Name')
      end

      it 'redirects to the user' do
        user = User.create!(valid_attributes)
        patch :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        user = User.create!(valid_attributes)
        patch :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create!(valid_attributes)
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(users_url)
    end
  end
end
