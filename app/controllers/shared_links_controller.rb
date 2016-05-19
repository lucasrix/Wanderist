class SharedLinksController < ApplicationController
  APP_PROTOCOL = :maplify

  def share
    redirect_to root_path unless browser.platform.ios?
    @link = "#{APP_PROTOCOL}://share?#{query}"
  end

  private

  def query
    URI(request.url).query
  end
end
