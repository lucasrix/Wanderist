class BlockingsController < ApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  load_and_authorize_resource :report
  before_action :authorize_resource

  def edit
    @action_token = params[:action_token]
  end

  def update
    @resource.blocked = params[:blocked]
    if @resource.save
      flash[:message] = I18n.t(:success, scope: [:blockings, :update], status: @resource.blocked)
    else
      flash[:message] = I18n.t(:error, scope: [:blockings, :update])
    end

    redirect_to :back
  end

  private

  def authorize_resource
    @resource = @report.reportable
    authorize! :update, @resource
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:action_token])
  end
end
