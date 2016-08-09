class SharedLinksController < ApplicationController
  APP_PROTOCOL = :maplify

  before_action :check_device

  def share
    @link = "#{APP_PROTOCOL}://share?#{query}"
  end

  def edit_password
    @link = "#{APP_PROTOCOL}://?#{query}"
  end

  private

  def check_device
    redirect_to root_path unless browser.platform.ios?
  end

  def query
    URI(request.url).query
  end
end
