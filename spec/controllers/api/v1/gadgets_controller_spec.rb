require 'rails_helper'

describe Api::V1::GadgetsController do
  include_context 'ability'

  let(:user) { create(:user) }

  before do
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    let(:params) { attributes_for(:gadget) }

    it 'should be success' do
      post :create, params
      should respond_with :created
    end

    it 'should create a gadget' do
      expect { post :create, params }.to change { Gadget.count }.by(1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Gadget).to receive(:save).and_return(false)
      post :create, params
      should respond_with :unprocessable_entity
    end

    context 'unauthorized user' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :create, Gadget
        post :create, params
        should respond_with :forbidden
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:gadget) { create(:gadget, user: user) }

    let(:params) do
      {id: gadget.id}
    end

    it 'should be success', :show_in_doc do
      delete :destroy, params
      should respond_with :ok
    end

    it 'should delete gadget' do
      expect { delete :destroy, params }.to change { Gadget.count }.by(-1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Gadget).to receive(:destroy).and_return(false)
      delete :destroy, params
      should respond_with :unprocessable_entity
    end

    context 'unauthorized user' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :destroy, Gadget
        delete :destroy, params
        should respond_with :forbidden
      end
    end

    context 'gadget doesnt exists' do
      it 'should return status 404' do
        gadget_id = Gadget.last.id + 1
        delete :destroy, id: gadget_id
        should respond_with :not_found
      end
    end
  end
end
