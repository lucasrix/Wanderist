module Api::V1
  class NotificationsController < Api::ApiController
    resource_description do
      short 'Notifications manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource through: :current_user
    after_action :make_read, if: :make_read?

    api! 'List of notifications'
    param :make_read, ['true', 'false'], required: false, desc: 'Set unread to false'
    def index
      notifications = @notifications.ordered
      render json: Response.new(notifications, scope: current_user)
    end

    private

    def make_read?
      params[:make_read] == 'true'
    end

    def make_read
      @notifications.update_all(unread: false)
    end
  end
end
