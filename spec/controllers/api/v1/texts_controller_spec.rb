require 'rails_helper'

describe Api::V1::TextsController do
  describe 'GET #terms_of_service' do
    it 'returns status 200', :show_in_doc do
      get :terms_of_service
      should respond_with :ok
    end
  end

  describe 'GET #privacy_policy' do
    it 'returns status 200', :show_in_doc do
      get :privacy_policy
      should respond_with :ok
    end
  end
end
