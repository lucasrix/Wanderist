require 'rails_helper'

describe Api::V1::StoryPointsController do
  describe 'GET #index' do
    let(:params) do
      {
        'location[latitude]' => '100',
        'location[longitude]' => '100',
        'radius' => '1'
      }
    end

    it 'should be success' do
      get :index, params
      should respond_with :ok
    end

    it 'creates StoryPointsService' do
      expect(StoryPointsService).to receive(:new).once.and_call_original
      get :index, params
    end

    it 'calls StoryPointsService#get_story_points' do
      expect_any_instance_of(StoryPointsService).to receive(:get_story_points)
      get :index, params
    end

  end

  describe 'POST #create' do

    it 'should be success' do
      params = attributes_for :story_point
      post :create, params
      should respond_with :ok
    end
  end
end