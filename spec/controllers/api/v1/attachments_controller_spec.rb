require 'rails_helper'

describe Api::V1::AttachmentsController do
  include_context 'ability'

  describe 'POST #create' do
    shared_examples 'attachments' do
      it 'should return status 201', :show_in_doc do
        post :create, params
        should respond_with :created
      end

      it 'creates a new attachment' do
        expect { post :create, params }.to change { Attachment.count }.by(1)
      end
    end

    context 'image attachment' do
      let(:params) { attributes_for(:attachment) }
      it_behaves_like 'attachments'
    end

    context 'video attachment' do
      let(:params) { attributes_for(:video_attachment) }
      it_behaves_like 'attachments'
    end

    context 'audio attachment' do
      let(:params) { attributes_for(:audio_attachment) }
      it_behaves_like 'attachments'
    end

    it 'should return status 422', :show_in_doc do
      post :create
      should respond_with :unprocessable_entity
    end
  end
end
