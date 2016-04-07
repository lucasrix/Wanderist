require 'rails_helper'

describe Api::V1::FollowingsController do
  include_context "ability"

  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:another_user) { create(:user) }

  before do
    allow(@controller).to receive(:current_user).and_return(user)
  end

  shared_examples "create_following" do
    it 'should be success', :show_in_doc do
      post :create, params
      should respond_with :created
    end

    it 'should create following' do
      expect { post :create, params }.to change { Following.count }.by(1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Following).to receive(:save).and_return(false)
      post :create, params
      should respond_with :unprocessable_entity
    end
  end

  shared_examples "destroy_following" do
    it 'should be success', :show_in_doc do
      delete :destroy, params
      should respond_with :ok
    end

    it 'should delete instance' do
      expect { delete :destroy, params }.to change { Following.count }.by(-1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Following).to receive(:destroy).and_return(false)
      delete :destroy, params
      should respond_with :unprocessable_entity
    end
  end

  describe 'POST #create' do
    context 'followings for story' do
      let(:params) do
        { story_id: story.id }
      end

      it_behaves_like "create_following"
    end

    context 'followings for another user' do
      let(:params) do
        { user_id: another_user.id }
      end

      it_behaves_like "create_following"
    end
  end

  describe 'DELETE #destroy' do
    context 'followings for story' do
      before do
        create(:following, user: user, followable: story)
      end

      let(:params) do
        { story_id: story.id }
      end

      it_behaves_like "destroy_following"
    end

    context 'followings for another user' do
      let(:params) do
        { user_id: another_user.id }
      end

      before do
        create(:following, user: user, followable: another_user)
      end

      it_behaves_like "destroy_following"
    end
  end
end
