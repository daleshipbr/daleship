class ApplicationController < ActionController::Base
  # rescue_from ActionController::InvalidAuthenticityToken do
  #   if Rails.env.production?
  #     redirect_to root_path
  #   else
  #     raise
  #   end
  # end
  #
  # rescue_from ActiveRecord::RecordNotFound do
  #   if Rails.env.production?
  #     redirect_to root_path
  #   else
  #     raise
  #   end
  # end

  include SetCurrentRequestDetails
  include SetLanguage
  include SetPlatform
  include SetVariant
  include Authentication
  include Authorization
  include Redirection
end