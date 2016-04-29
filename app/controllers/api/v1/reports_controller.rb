module Api::V1
  class ReportsController < Api::ApiController
    resource_description do
      short 'Reports manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_resource :story
    load_resource :story_point
    load_and_authorize_resource through: [:story, :story_point]
    before_action :authorize_parent

    api! 'Create report'
    param :kind, Report::REPORT_KIND, required: true, desc: 'Abuse kind'
    error 404, 'Story Point not found.'
    error 404, 'Story not found.'
    def create
      if @report.save
        render json: Response.new(resource, scope: current_user), status: :created
      else
        render json: Response.new(resource, scope: current_user), status: :unprocessable_entity
      end
    end

    private

    def resource
      @story || @story_point
    end

    def report_params
      params.permit(:kind)
    end

    def authorize_parent
      authorize! :read, resource
    end
  end
end
