require 'rails_helper'

describe Api::V1::StoryPointsController do
  include_context 'ability'

  describe 'GET #index' do
    let(:location) { create(:location) }
    let!(:story_points) { create_list(:story_point_with_attachment, 2, :with_tags, location: location) }
    let(:params) do
      {
        radius: 1,
        location: {
          latitude:  location.latitude,
          longitude: location.longitude
        }
      }
    end

    it 'should be success', :show_in_doc do
      get :index, params
      should respond_with :ok
    end

    it 'creates StoryPointsService' do
      expect(StoryPointsService).to receive(:new).once.and_call_original
      get :index, params
    end

    it 'calls StoryPointsService#within_origin' do
      expect_any_instance_of(StoryPointsService).to receive(:within_origin)
      get :index, params
    end
  end

  describe 'GET #show' do
    let(:story_point) { create(:story_point, user: user) }

    it 'should be success', :show_in_doc do
      get :show, id: story_point.id
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    let!(:stories){ create_list(:story, 3, user: user) }
    let(:params){ attributes_for(:story_point).merge({ location: attributes_for(:location), story_ids: stories.map(&:id) }) }

    it 'should be success' do
      post :create, params
      should respond_with :created
    end

    it 'should create a story point' do
      expect { post :create, params }.to change { StoryPoint.count }.by(1)
    end

    it 'should create a location', :show_in_doc do
      attachment = create(:attachment, user: user)
      params[:attachment_id] = attachment.id
      expect { post :create, params }.to change { Location.count }.by(1)
    end

    it 'should return status 422', :show_in_doc do
      params[:location][:latitude] = nil
      post :create, params
      should respond_with :unprocessable_entity
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :create, StoryPoint
        post :create, params
        should respond_with :forbidden
      end

      it 'should return status 403' do
        ability.cannot :read, Attachment
        attachment = create(:attachment, user: user)
        params[:attachment_id] = attachment.id
        post :create, params
        should respond_with :forbidden
      end
    end

  end

  describe 'PUT #update' do
    let!(:story_point) { create(:story_point, user: user) }

    it 'should return status 200', :show_in_doc do
      params = attributes_for(:story_point)
      params[:id] = story_point.id
      params.delete(:kind)

      put :update, params
      should respond_with :ok
    end

    it 'updates story point' do
      new_caption = Faker::Hipster.word
      put :update, id: story_point.id, caption: new_caption
      expect(StoryPoint.where(caption: new_caption)).not_to be_empty
    end

    it 'should return 422' do
      wrong_caption = Faker::Lorem.paragraph
      put :update, id: story_point.id, caption: wrong_caption
      should respond_with :unprocessable_entity
    end

  end

  describe 'DELETE #destroy' do
    let!(:story_point) { create(:story_point, user: user) }

    it 'should be success', :show_in_doc do
      delete :destroy, id: story_point.id
      should respond_with :ok
    end

    it 'should delete instance' do
      expect { delete :destroy, id: story_point.id }.to change { StoryPoint.count }.by(-1)
    end

    it 'should return status 422' do
      allow_any_instance_of(StoryPoint).to receive(:destroy).and_return(false)
      delete :destroy, id: story_point.id
      should respond_with :unprocessable_entity
    end
  end
end
