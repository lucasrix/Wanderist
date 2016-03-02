require 'rails_helper'

describe Api::V1::Auth::ProviderSessionsController do
  let(:user) { create(:user) }

  describe "POST #create" do
    it 'should return 200', :show_in_doc do
      token = Faker::Lorem.characters(212)
      allow(ProviderAuthService).to receive(:facebook_auth).with(token).once.and_return(user)
      expect(controller).to receive(:sign_in).once
      post :create, facebook_access_token: token
      should respond_with :success
    end

    it 'should return 404', :show_in_doc do
      post :create, facebook_access_token: 'wrong access token'
      should respond_with :not_found
    end
  end
end