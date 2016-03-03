module Api::V1
  class StoriesController < Api::ApiController
    resource_description do
      short 'Stories manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end


    api! 'Create a story'
    param :name, String, desc: 'Name', required: true
    param :description, String, desc: 'Description', required: true
    param :private, [true, false], desc: 'Discoverable state', required: true
    example <<-EOS
    GET /api/v1/stories
    {
      "name": "Story",
      "description": "Story description",
      "private": false
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
            "private": false
          }
        ]
      }
    }
    EOS
    def create
    end
  end
end
