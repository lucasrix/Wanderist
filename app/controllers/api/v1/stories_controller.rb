module Api::V1
  class StoriesController < Api::ApiController
    resource_description do
      short 'Stories manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource

    def_param_group :story do
      param :name, String, desc: 'Name', required: true, action_aware: true
      param :description, String, desc: 'Description', required: true, action_aware: true
      param :discoverable, [true, false], desc: 'Discoverable state', required: true, action_aware: true
      param :story_point_ids, Array, of: Integer, required: false
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
    def story_params
      params.permit(:name, :description, :discoverable, story_point_ids: [])
    end
  end
end
