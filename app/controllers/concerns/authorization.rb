# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    delegate :allow?, to: :current_permission
    helper_method :allow?

    delegate :allow_param?, to: :current_permission
    helper_method :allow_param?

    before_action do
      if current_permission.allow?(params[:controller], params[:action], current_resource)
        current_permission.permit_params! params
      elsif logged_in?
        redirect_home
      else
        authenticate
      end
    end
  end

  private
  def current_resource
    @model
  end

  def current_permission
    @permission = Permission.permission_for(Current.user)
  end
end
