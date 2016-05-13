require 'rails_helper'

describe Api::V1::DiscoversController do
  include_context 'ability'

  before do
    create_story_points_with_city
    StoryPoint.last.stories << create(:story)
  end

  describe 'GET #discover' do
    let(:target_location) { create(:location, cities_list[:kyiv]) }

    context 'origin mode' do
      let(:params) do
        { radius: 100_000,
          location: {
            latitude:  target_location.latitude,
            longitude: target_location.longitude
          }
        }
      end

      it 'should be success', :show_in_doc do
        get :discover, params
        should respond_with :ok
      end
    end

    context 'city mode' do
      let(:params) do
        { radius: nil,
          location: {
            latitude:  target_location.latitude,
            longitude: target_location.longitude
          }
        }
      end

      it 'should be success', :show_in_doc do
        get :discover, params
        should respond_with :ok
      end
    end

    context 'whole world mode', :show_in_doc do
      let(:params) do
        { radius: nil, location: {} }
      end

      it 'should be success' do
        get :discover, params
        should respond_with :ok
      end
    end

    context 'user has report' do
      let(:params) do
        { radius: 100_000,
          location: {
            latitude:  target_location.latitude,
            longitude: target_location.longitude
          }
        }
      end

      context 'story_point' do
        it 'doesnt returns reported story_point' do
          reported_story_point = StoryPoint.first
          allow(ReportEmailJob).to receive(:perform_later)
          create(:report, reportable: reported_story_point, user: user)
          get :discover, params
          text = reported_story_point.text
          expect(response.body).not_to match(text)
        end
      end

      context 'story' do
        it 'doesnt returns reported story' do
          reported_story = Story.first
          allow(ReportEmailJob).to receive(:perform_later)
          create(:report, reportable: reported_story, user: user)
          get :discover, params
          description = reported_story.description
          expect(response.body).not_to match(description)
        end
      end
    end
  end
end
