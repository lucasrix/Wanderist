module Api
  class ApiController < ApplicationController
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json do
          response = Response.new
          response.add_error_message(exception.message)
          render json: response, status: :forbidden
        end
      end
    end
  end
end
