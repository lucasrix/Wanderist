require 'rails_helper'

describe Api::V1::AttachmentsController do
  describe 'POST #create' do
    let(:params) { attributes_for(:attachment) }

    it 'should return status 201', :show_in_doc do
      post :create, params
      should respond_with :created
    end

    it 'creates a new attachment' do
      expect { post :create, params }.to change { Attachment.count }.by(1)
    end

    it 'should return status 422', :show_in_doc do
      post :create
      should respond_with :unprocessable_entity
    end
  end


end