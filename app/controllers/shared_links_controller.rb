class SharedLinksController < ApplicationController
  def share
    redirect_to root_path unless browser.platform.ios?
    @link = params[:link]
  end
end
