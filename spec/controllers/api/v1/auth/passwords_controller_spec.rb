require 'rails_helper'

describe Api::V1::Auth::PasswordsController do
  let!(:user) { create(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #password' do
    it 'returns status 200', :show_in_doc do
      post :create, email: user.email, redirect_url: Faker::Internet.url
      should respond_with :ok
    end

    it 'returns status 404', :show_in_doc do
      post :create, email: Faker::Internet.email, redirect_url: Faker::Internet.url
      should respond_with :not_found
    end
  end

  describe 'PUT #password' do
    let(:password) { Faker::Internet.password }

    it 'returns status 200', :show_in_doc do
      auth_headers = user.create_new_auth_token
      request.headers.merge!(auth_headers)
      put :update, password: password, password_confirmation: password
      should respond_with :ok
    end

    it 'returns status 401', :show_in_doc do
      post :create, email: Faker::Internet.email, password: password
      should respond_with :unauthorized
    end
  end
end
