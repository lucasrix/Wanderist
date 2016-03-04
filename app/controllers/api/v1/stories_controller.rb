module Api::V1
  class StoriesController < Api::ApiController
    resource_description do
      short 'Stories manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    def_param_group :story do
      param :name, String, desc: 'Name', required: true, action_aware: true
      param :description, String, desc: 'Description', required: true, action_aware: true
      param :discoverable, [true, false], desc: 'Discoverable state', required: true, action_aware: true
    end


    api! 'Create a story'
    param_group :story
    example <<-EOS
    POST /api/v1/stories
    {
      "name": "Story",
      "description": "Story description",
      "discoverable": false
    }
    201
    {
      "success": true,
      "data": {
        "story": [
          {
            "id": 1,
            "name": "Story",
            "description": "Story description",
            "discoverable": false
          }
        ]
      }
    }
    EOS
    def create
    end


    api! 'Update a story'
    param_group :story
    example <<-EOS
    PUT /api/v1/stories/1
    {
      "name": "New Story Name",
      "description": "New story description",
      "discoverable": true
    }
    200
    {
      "success": true,
      "data": {
        "story": [
          {
            "id": 1,
            "name": "New Story Name",
            "description": "New story description",
            "discoverable": true
          }
        ]
      }
    }
    EOS
    def update
    end

    api! 'Delete a story'
    error 404, 'Story not found.'
    example <<-EOS
    DELETE /api/v1/stories/1
    200
    {
      "success": true,
      "data": {
        "story": [
          {
            "id": 1,
            "name": "New Story Name",
            "description": "New story description",
            "private": true
          }
        ]
      }
    }
    EOS
    def destroy
    end
  end
end
