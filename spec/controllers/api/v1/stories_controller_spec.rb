require 'rails_helper'

describe Api::V1::StoriesController do
  include_context "ability"

  describe 'POST #create' do
    let(:params){ attributes_for(:story) }

    it 'should be success', :show_in_doc do
      post :create, params
      should respond_with :created
    end

    it 'should create a story' do
      expect { post :create, params }.to change { Story.count }.by(1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Story).to receive(:save).and_return(false)
      post :create, params
      should respond_with :unprocessable_entity
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :create, Story
        post :create, params
        should respond_with :forbidden
      end
    end

  end

  describe 'PUT #update' do
    let!(:story) { create(:story, user: user) }

    it 'should return status 200' do
      put :update, id: story.id
      should respond_with :ok
    end

    it 'updates story', :show_in_doc do
      params = attributes_for(:story)
      story_points = create_list(:story_point, 3)
      params[:story_point_ids] = story_points.map(&:id)
      put :update, id: story.id, **params
      expect(Story.exists?(name: params[:name])).to be_truthy
    end

    it 'should remove story points from story' do
      story = create(:story_with_story_points)
      put :update, id: story.id, story_point_ids: []
      story = Story.find(story.id)
      expect(story.story_points).to be_empty
    end

    it 'should return 422', :show_in_doc do
      wrong_name = Faker::Lorem.paragraph
      put :update, id: story.id, name: wrong_name
      should respond_with :unprocessable_entity
    end

    it 'should return 404', :show_in_doc do
      params = attributes_for(:story)
      params[:story_point_ids] = [101]
      put :update, id: story.id, **params
      should respond_with :not_found
    end

    it 'should return 404' do
      ability.cannot :read, StoryPoint
      params = attributes_for(:story)
      story_points = create_list(:story_point, 3)
      params[:story_point_ids] = story_points.map(&:id)
      put :update, id: story.id, **params
      should respond_with :not_found
    end

  end

  describe 'DELETE #destroy' do
    let!(:story) { create(:story, user: user) }

    it 'should be success', :show_in_doc do
      delete :destroy, id: story.id
      should respond_with :ok
    end

    it 'should delete instance' do
      expect { delete :destroy, id: story.id }.to change { Story.count }.by(-1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Story).to receive(:destroy).and_return(false)
      delete :destroy, id: story.id
      should respond_with :unprocessable_entity
    end
  end
end