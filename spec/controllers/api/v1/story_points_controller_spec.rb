require 'rails_helper'

describe Api::V1::StoryPointsController do
  let(:user) { create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(@controller).to receive(:current_ability).and_return(ability)
  end

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
    let(:params){ attributes_for(:story_point) }

    it 'should be success' do
      post :create, params
      should respond_with :created
    end

    it 'should be unprocessable entity' do
      post :create
      should respond_with :unprocessable_entity
    end

    it 'should create a story point' do
      expect { post :create, params }.to change { StoryPoint.count }.by(1)
    end

    it 'should be unauthorized' do
      ability.cannot :create, StoryPoint
      post :create, params
      should respond_with :forbidden
    end
  end
end