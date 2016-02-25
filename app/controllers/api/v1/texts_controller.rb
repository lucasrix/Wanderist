module Api::V1
  class TextsController < Api::BaseController
    resource_description do
      short 'Texts manager'
      api_versions 'v1'
    end


    api! 'Terms of service'
    example <<-EOS
    GET /api/v1/terms_of_service
    200
    <h1>Policy</h1>
    EOS
    def terms_of_service
    end

    api! 'Privacy policy'
    example <<-EOS
    GET /api/v1/privacy_policy
    200
    <h1>Policy</h1>
    EOS
    def privacy_policy
    end

  end
end