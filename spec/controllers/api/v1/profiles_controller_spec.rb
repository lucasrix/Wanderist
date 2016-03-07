require 'rails_helper'

describe Api::V1::ProfilesController do
  include_context "ability"

  before do
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe 'PUT #update' do
    let(:params){ attributes_for(:profile) }

    it 'should be success', :show_in_doc do
      put :update, params
      should respond_with :ok
    end

    it 'should update a profile' do
      put :update, params
      expect(Profile.exists?(first_name: params[:first_name])).to be_truthy
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :update, Profile
        put :update, params
        should respond_with :forbidden
      end
    end

  end
end