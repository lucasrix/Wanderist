require 'rails_helper'

describe Api::V1::NotificationsController do
  include_context 'ability'

  before do
    allow(subject).to receive(:current_user).and_return(user)
    allow(CreateOwnerNotificationsService).to receive(:call)
    allow(CreateFollowerNotificationsService).to receive(:call)
  end

  describe 'GET #index' do
    let(:story) { create(:story_with_story_points, user: user) }
    let!(:notifications) { create_list(:notification, 10, notificable: story, user: user, action_user: create(:user)) }

    it 'should be success', :show_in_doc do
      get :index
      should respond_with :ok
    end

    it 'set unread to false' do
      get :index
      unread = user.notifications.pluck(:unread).uniq
      expect(unread).to match_array([false])
    end

    context 'unauthorized' do
      it 'should return status 403', :show_in_doc do
        ability.cannot :index, Notification
        reload_ability(ability)
        get :index
        should respond_with :forbidden
      end
    end
  end
end
