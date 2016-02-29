module Api::V1
  class StoryPointsController < Api::BaseController
    resource_description do
      short 'Story points manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    api! 'Create a story point'
    param :type, ["audio", "video", "photo", "text"], required: true, desc: 'Type'
    param :caption, String, required: true, desc: 'Caption'
    param :attachment_id, Integer, required: true, desc: 'Attachment'
    param :location, Hash, desc: "Location info", required: true do
      param :latitude, Float, desc: "Latitude coordinate", required: true
      param :longitude, Float, desc: "Longitude coordinate", required: true
    end
    param :tags, Array, of: String, desc: "List of tags"
    example <<-EOS
    POST /api/v1/story_points
    {
      "type": "photo",
      "caption": "My Awesome Story Point",
      "attachment_id": 1,
      "location": {
        "latitude": 48.4500,
        "longitude": 34.9833
      },
      "tags": ["tag1", "tag2", "tag3"]
    }
    201
    {
      "success": true,
      "data": {
        "story_point": {
          "id": 13,
          "type": "photo",
          "caption": "My Awesome Story Point",
          "attachment_id": 1,
          "location": {
            "id": 1,
            "latitude": 48.4500,
            "longitude": 34.9833
          },
          "tags": [
            {
              "id": 1,
              "name": "tag1"
            },
            {
              "id": 2,
              "name": "tag2"
            },
            {
              "id": 3,
              "name": "tag3"
            }
          ]
        }
      }
    }
    EOS
    def create
    end

    api! 'Update a story point'
    param :type, ["audio", "video", "photo", "text"], required: false, desc: 'Type'
    param :caption, String, required: false, desc: 'Caption'
    param :attachment_id, Integer, required: false, desc: 'Attachment'
    param :location, Hash, desc: "Location info", required: false do
      param :latitude, Float, desc: "Latitude coordinate", required: false
      param :longitude, Float, desc: "Longitude coordinate", required: false
    end
    param :tags, Array, of: String, desc: "List of tags"
    error 404, 'Story Point not found.'

    example <<-EOS
    PUT /api/v1/story_points/13
    {
      "type": "photo",
      "caption": "New Story Point Caption",
      "attachment_id": 3,
      "story_id": 1
    }
    200
    {
      "success": true,
      "data": {
        "story_point": {
          "id": 13,
          "type": "photo",
          "caption": "New Story Point Caption",
          "attachment_id": 3,
          "story_id": 1,
          "location": {
            "id": 1,
            "latitude": 48.4500,
            "longitude": 34.9833
          },
          "tags": [
            {
              "id": 1,
              "name": "tag1"
            },
            {
              "id": 2,
              "name": "tag2"
            },
            {
              "id": 3,
              "name": "tag3"
            }
          ]
        }
      }
    }
    EOS
    def update
    end


    api! 'Delete a story point'
    error 404, 'Story Point not found.'

    example <<-EOS
    DELETE /api/v1/story_points/13
    200
    {
      "success": true,
      "data": {
        "story_point": {
          "id": 13,
          "type": "photo",
          "caption": "New Story Point Caption",
          "attachment_id": 3,
          "story_id": 1,
          "location": {
            "id": 1,
            "latitude": 48.4500,
            "longitude": 34.9833
          },
          "tags": [
            {
              "id": 1,
              "name": "tag1"
            },
            {
              "id": 2,
              "name": "tag2"
            },
            {
              "id": 3,
              "name": "tag3"
            }
          ]
        }
      }
    }
    EOS
    def destroy
    end

  end
end