require 'rails_helper'

describe Api::V1::DiscoversController do
  include_context 'ability'

  before do
    allow(@controller).to receive(:current_user).and_return(user)
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
  end
end
