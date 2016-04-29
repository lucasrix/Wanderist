require 'rails_helper'

describe Api::V1::StoriesController do
  include_context 'ability'

  describe 'GET #index scope: :current_user' do
    let(:story) { create(:story_with_story_points, user: user) }
    let(:params) do
      {
        scope: 'current_user',
        page: 1
      }
    end

    it 'should be success', :show_in_doc do
      get :index, params
      should respond_with :ok
    end

    it 'paginates stories' do
      create_list(:story, 30, user: user)
      per_page = Kaminari.config.default_per_page
      get :index, params
      resp = ActiveSupport::JSON.decode(response.body)
      stories = resp['data']['stories']
      expect(stories.length).to eq(per_page)
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :index, Story
        reload_ability(ability)
        get :index, params
        should respond_with :forbidden
      end
    end
  end

  describe 'GET #index' do
    let(:stories) { create_list(:story, 30, user: user) }
    let(:story_point) { create(:story_point, user: user, stories: stories) }

    it 'should be success', :show_in_doc do
      get :index, story_point_id: story_point.id
      should respond_with :ok
    end

    it 'paginates stories' do
      per_page = Kaminari.config.default_per_page
      get :index, story_point_id: story_point.id, page: 1
      resp = ActiveSupport::JSON.decode(response.body)
      all_stories = resp['data']['stories']
      expect(all_stories.length).to eq(per_page)
    end

    context 'stories of particular user' do
      let(:another_user) { create(:user) }
      let(:params) do
        {
          user_id: another_user.id
        }
      end

      before do
        create_list(:story, 10, user: another_user)
        create_list(:story, 10)
        reload_ability(ability)
      end

      it 'returns stories of another user' do
        get :index, params
        stories = subject.instance_variable_get(:@stories)
        another_user_stories = another_user.stories
        expect(stories).to match_array(another_user_stories)
      end
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :index, Story
        reload_ability(ability)
        get :index, story_point_id: story_point.id
        should respond_with :forbidden
      end
    end
  end

  describe 'GET #show' do
    let(:story) { create(:story_with_story_points, user: user) }

    it 'should be success', :show_in_doc do
      get :show, id: story.id
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    let(:params) { attributes_for(:story) }

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
        reload_ability(ability)
        post :create, params
        should respond_with :forbidden
      end
    end
  end

  describe 'PUT #update' do
    let!(:story) { create(:story_with_story_points, user: user) }

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

    it 'should remove story points from story', :show_in_doc do
      story = create(:story_with_story_points, user: user)
      put :update, id: story.id, story_point_ids: []
      story.reload
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
      reload_ability(ability)
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
