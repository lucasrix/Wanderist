require 'rails_helper'

describe Api::V1::UsersController do
  include_context "ability"

  describe 'GET #followers' do
    let(:another_users) { create_list(:user, 5) }

    let(:params) do
      {
        scope: 'current_user'
      }
    end

    before do
      another_users.each do |another_user|
        create(:following, user: another_user, followable: user)
      end
    end

    it 'should be success', :show_in_doc do
      get :followers, params
      should respond_with :ok
    end

    it 'should return collection of followers' do
      get :followers, params
      received_response = JSON.parse(response.body)['data']['users']
      expected_response = serialized_collection(another_users, UserSerializer)
      expect(received_response).to match_array(expected_response)
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :followers, User
        reload_ability(ability)
        get :followers, params
        should respond_with :forbidden
      end
    end
  end

  describe 'GET #followed' do

    let(:another_users) { create_list(:user, 5) }

    let(:params) do
      {
        scope: 'current_user'
      }
    end

    before do
      another_users.each do |another_user|
        create(:following, user: user, followable: another_user)
      end
    end

    it 'should be success', :show_in_doc do
      get :followed, params
      should respond_with :ok
    end

    before do
      another_users.each do |another_user|
        create(:following, user: another_user, followable: user)
      end
    end

    it 'should return collection of followers' do
      get :followed, params
      received_response = JSON.parse(response.body)['data']['users']
      expected_response = serialized_collection(another_users, UserSerializer)
      expect(received_response).to match_array(expected_response)
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :followed, User
        reload_ability(ability)
        get :followed, params
        should respond_with :forbidden
      end
    end
  end

  describe 'PUT #update' do
    let(:params) do
      {
        email: Faker::Internet.email,
        scope: 'current_user'
      }
    end

    it 'should be success', :show_in_doc do
      put :update, params
      should respond_with :ok
    end

    it 'should update a profile' do
      put :update, params
      expect(User.exists?(email: params[:email])).to be_truthy
    end

    it 'should return status 422' do
      allow_any_instance_of(User).to receive(:update).and_return(false)
      put :update, params
      should respond_with :unprocessable_entity
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :update, User
        reload_ability(ability)
        put :update, params
        should respond_with :forbidden
      end
    end

    context 'user updates email to existing email' do
      it 'should return status 422' do
        another_user = create(:user)
        params = {scope: 'current_user', email: another_user.email}
        put :update, params
        should respond_with :unprocessable_entity
      end
    end
  end
end

