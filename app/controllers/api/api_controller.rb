module Api
  class ApiController < ApplicationController
    rescue_from CanCan::AccessDenied do |exception|
      response = Response.new
      response.add_error_message(exception.message)
      render json: response, status: :forbidden
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      response = Response.new
      response.add_error_message(exception.message)
      render json: response, status: :not_found
    end

    rescue_from Geokit::Geocoders::GeocodeError do |exception|
      response = Response.new
      response.add_error_message(exception.message)
      render json: response, status: :unprocessable_entity
    end

    def create_entity(entity)
      if entity.save
        render json: Response.new(entity, scope: current_user), status: :created
      else
        render json: Response.new(entity, scope: current_user), status: :unprocessable_entity
      end
    end

    def update_entity(entity, params)
      if entity.update(params)
        render json: Response.new(entity, scope: current_user)
      else
        render json: Response.new(entity, scope: current_user), status: :unprocessable_entity
      end
    end

    def destroy_entity(entity)
      if entity.destroy
        render json: Response.new(entity, scope: current_user)
      else
        render json: Response.new(entity, scope: current_user), status: :unprocessable_entity
      end
    end
  end
end
