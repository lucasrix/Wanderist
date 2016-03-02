module Api::V1
  class AttachmentsController < Api::ApiController
    resource_description do
      short 'Attachments manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'

    end

    api! 'Create an attachment'
    param :kind, ["audio", "video", "photo"], required: true, desc: 'Kind'
    param :file, File, required: true, desc: 'File'
    error 400, 'Too big file.'

    example <<-EOS
    POST /api/v1/attachments
    {
      "kind": "photo",
      "file": "{BLOB DATA}"
    }
    201
    {
      "success": true,
      "data": {
        "attachment": {
          "id": 1,
          "kind": "photo",
          "url": "/link/file_name.jpg"
        }
      }
    }
    EOS
    def create
    end
  end
end
