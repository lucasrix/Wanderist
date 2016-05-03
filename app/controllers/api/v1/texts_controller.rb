module Api::V1
  class TextsController < Api::ApiController
    resource_description do
      short 'Texts manager'
      api_versions 'v1'
    end

    api! 'About of service. Respond with HTML content.'
    def about
    end

    api! 'Terms of service. Respond with HTML content.'
    def terms_of_service
    end

    api! 'Privacy policy. Respond with HTML content.'
    def privacy_policy
    end
  end
end
