module Api::V1
  class StoriesController < Api::ApiController
    resource_description do
      short 'Stories manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource :user, only: :index
    load_and_authorize_resource through: :user, shallow: true, only: :index
    load_and_authorize_resource only: [:show, :create, :update, :destroy]

    def_param_group :story do
      param :name, String, desc: 'Name', required: true, action_aware: true
      param :description, String, desc: 'Description', required: false, action_aware: true
      param :discoverable, [true, false], desc: 'Discoverable state', required: true, action_aware: true
      param :story_point_ids, Array, of: Integer, required: false
    end

    api! 'Show list of stories'
    param :page, Integer, desc: 'Page number for pagination', required: false

    def index
      stories = story_point_stories || user_stories
      current_stories = paginate(stories) if stories
      render json: Response.new(current_stories, scope: current_user)
    end

    api! 'Show a story info'
    error 404, 'Story not found'
    error 404, 'StoryPoint not found'
    def show
      render json: Response.new(@story, scope: current_user)
    end

    api! 'Create a story'
    param_group :story
    error 422, 'Validation error.'
    def create
      create_entity(@story)
    end

    api! 'Update a story'
    param_group :story
    error 422, 'Validation error.'
    def update
      if params[:story_point_ids].present?
        StoryPoint.accessible_by(current_ability, :read).find(params[:story_point_ids])
      end

      update_entity(@story, story_params)
    end

    api! 'Delete a story'
    error 404, 'Story not found.'
    error 422, 'Validation errors.'
    def destroy
      destroy_entity(@story)
    end

    private

    def paginate(collection)
      params[:page].present? ? collection.page(params[:page]) : collection
    end

    def user_stories
      @stories = current_user.stories if params[:scope] == 'current_user'
      @stories
    end

    def story_point_stories
      if params[:story_point_id].present?
        story_point = StoryPoint.accessible_by(current_ability, :read).find(params[:story_point_id])
        story_point.stories
      end
    end

    def story_params
      params.permit(:name, :description, :discoverable, story_point_ids: [])
    end
  end
end
