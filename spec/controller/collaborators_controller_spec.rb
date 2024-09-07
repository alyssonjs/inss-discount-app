require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let!(:user) { create(:user, role: 'admin') }
  let!(:collaborator) { create(:collaborator, user: user) }

  before do
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    it 'assigns @collaborators and renders the index template' do
      get :index
      expect(assigns(:collaborators)).to eq([collaborator])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @collaborator and renders the show template' do
      get :show, params: { id: collaborator.id }
      expect(assigns(:collaborator)).to eq(collaborator)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new collaborator and renders the new template' do
      get :new
      expect(assigns(:collaborator)).to be_a_new(Collaborator)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested collaborator and renders the edit template' do
      get :edit, params: { id: collaborator.id }
      expect(assigns(:collaborator)).to eq(collaborator)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new collaborator and redirects to the show page' do
        expect {
          post :create, params: { collaborator: attributes_for(:collaborator) }
        }.to change(Collaborator, :count).by(1)
        expect(response).to redirect_to(Collaborator.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new collaborator and renders the new template' do
        expect {
          post :create, params: { collaborator: attributes_for(:collaborator, name: '') }
        }.not_to change(Collaborator, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the collaborator and redirects to the show page' do
        patch :update, params: { id: collaborator.id, collaborator: { name: 'Updated Name' } }
        collaborator.reload
        expect(collaborator.name).to eq('Updated Name')
        expect(response).to redirect_to(collaborator)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the collaborator and renders the edit template' do
        patch :update, params: { id: collaborator.id, collaborator: { name: nil } }
        expect(collaborator.reload.name).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the collaborator and redirects to the index page' do
      expect {
        delete :destroy, params: { id: collaborator.id }
      }.to change(Collaborator, :count).by(-1)
      expect(response).to redirect_to(collaborators_url)
    end
  end

  describe 'GET #calculate_inss_discount' do
    it 'returns the INSS discount as JSON' do
      get :calculate_inss_discount, params: { salary: 3000 }, xhr: true
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
    end
  end

  describe 'GET #report' do
    it 'assigns @report_data and renders the report template' do
      get :report
      expect(assigns(:report_data)).not_to be_empty
      expect(response).to render_template(:report)
    end
  end
end
