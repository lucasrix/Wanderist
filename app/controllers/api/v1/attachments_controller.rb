module Api::V1
  class AttachmentsController < Api::ApiController
    resource_description do
      short 'Attachments manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'

    end

    load_and_authorize_resource

    api! 'Create an attachment'
    param :file, File, required: true, desc: 'File'
    error 400, 'Too big file.'

    def create
      create_entity(@attachment)
    end

    private
    def attachment_params
      params.permit(:file)
    end
  end
end
