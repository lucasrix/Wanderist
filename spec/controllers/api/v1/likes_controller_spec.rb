require 'rails_helper'

describe Api::V1::LikesController do
  let!(:story) { create(:story_with_story_points) }
  let!(:story_point) { create(:story_point) }

  include_context 'ability'

  shared_examples 'create_like' do
    it 'should be success', :show_in_doc do
      post :create, params
      should respond_with :created
    end

    it 'should create a like' do
      expect { post :create, params }.to change { Like.count }.by(1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Like).to receive(:save).and_return(false)
      post :create, params
      should respond_with :unprocessable_entity
    end
  end

  shared_examples 'destroy_like' do
    it 'should be success', :show_in_doc do
      delete :destroy, params
      should respond_with :ok
    end

    it 'should delete instance' do
      expect { delete :destroy, params }.to change { Like.count }.by(-1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Like).to receive(:destroy).and_return(false)
      delete :destroy, params
      should respond_with :unprocessable_entity
    end
  end

  describe 'POST #create' do
    context 'likes for story' do
      let(:params) do
        { story_id: story.id }
      end

      it_behaves_like 'create_like'
    end

    context 'likes for story_point' do
      let(:params) do
        { story_point_id: story_point.id }
      end

      it_behaves_like 'create_like'
    end
  end

  describe 'DELETE #destroy' do
    context 'likes for story' do
      before do
        create(:like, user: user, likable: story)
      end

      let(:params) do
        { story_id: story.id }
      end

      it_behaves_like 'destroy_like'
    end

    context 'likes for story_point' do
      let(:params) do
        { story_point_id: story_point.id }
      end

      before do
        create(:like, user: user, likable: story_point)
      end

      it_behaves_like 'destroy_like'
    end
  end
end
