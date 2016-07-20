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

    context 'video attachment', skip_on_ci: true do
      let(:params) { attributes_for(:video_mp4_attachment) }
      it_behaves_like 'attachments'
    end

    context '.mov attachment', skip_on_ci: true do
      let(:params) { attributes_for(:video_mov_attachment) }
      it_behaves_like 'attachments'
    end

    context '.m4a audio attachment' do
      let(:params) { attributes_for(:audio_m4a_attachment) }
      it_behaves_like 'attachments'
    end
    context '.mp3 audio attachment' do
      let(:params) { attributes_for(:audio_mp3_attachment) }
      it_behaves_like 'attachments'
    end

    it 'should return status 422', :show_in_doc do
      post :create
      should respond_with :unprocessable_entity
    end
  end
end
