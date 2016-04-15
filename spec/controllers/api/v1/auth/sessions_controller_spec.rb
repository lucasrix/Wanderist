require 'rails_helper'

describe Api::V1::Auth::SessionsController do
  let(:user) { create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:password) { Faker::Internet.password }

    it 'returns status 200', :show_in_doc do
      user = create(:user, password: password)
      post :create, email: user.email, password: password
      should respond_with :ok
    end

    it 'returns status 401', :show_in_doc do
      post :create, email: Faker::Internet.email, password: password
      should respond_with :unauthorized
    end
  end
end
