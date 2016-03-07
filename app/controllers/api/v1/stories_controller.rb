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
    end

    api! 'Create a story'
    param_group :story
    error 422, 'Validation error.'
    def create
      if @story.save
        render json: Response.new(@story), status: :created
      else
        render json: Response.new(@story), status: :unprocessable_entity
      end
    end

    api! 'Update a story'
    param_group :story
    error 422, 'Validation error.'
    def update
      if @story.update(story_params)
        render json: Response.new(@story)
      else
        render json: Response.new(@story), status: :unprocessable_entity
      end
    end

    api! 'Delete a story'
    error 404, 'Story not found.'
    def destroy
      if @story.destroy
        render json: Response.new(@story)
      else
        render json: Response.new(@story), status: :unprocessable_entity
      end
    end

    private
    def story_params
      params.permit(:name, :description, :discoverable)
    end
  end
end
