require 'rails_helper'

describe Api::V1::ProfilesController do
  include_context "ability"

  before do
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #show' do
    it 'should be success', :show_in_doc do
      get :show
      should respond_with :ok
    end

    it 'should be success', :show_in_doc do
      profile = create(:profile)
      get :show, id: profile.id
      should respond_with :ok
    end

    it 'should returns status 404', :show_in_doc do
      get :show, id: Faker::Number.between(-10, -1)
      should respond_with :not_found
    end
  end

  describe 'PUT #update' do
    let(:params){ attributes_for(:profile, location: nil) }
    let(:location_params) { attributes_for(:location) }
    let(:params_with_location) { params.merge(location: location_params)  }

    context 'location params arent presented' do
      it 'should be success', :show_in_doc do
        put :update, params
        should respond_with :ok
      end
    end

    context 'location params are presented' do
      it 'should be success', :show_in_doc do
        put :update, params_with_location
        should respond_with :ok
      end
    end

    context 'profile hasnt location' do
      it 'creates new location' do
        user.profile.location = nil
        expect { put :update, params_with_location }.to change { Location.count }.by(1)
      end
    end

    context 'profile has location' do
      it 'updates profile location' do
        location = user.profile.location
        allow(location).to receive(:update_attributes)
        expect(location).to receive(:update_attributes) { location_params }
        put :update, params_with_location
      end
    end

    it 'should update a profile' do
      put :update, params
      expect(Profile.exists?(first_name: params[:first_name])).to be_truthy
    end

    it 'should return status 422' do
      allow_any_instance_of(Profile).to receive(:update).and_return(false)
      put :update, params
      should respond_with :unprocessable_entity
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
