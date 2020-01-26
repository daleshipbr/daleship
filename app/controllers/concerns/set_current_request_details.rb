# frozen_string_literal: true

module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.ip_address = request.ip
      Current.request_id = request.uuid
      Current.user_agent = (ENV["user_agent"] if Rails.env.test?) || params[:device] || request.user_agent
      Current.accept_language = request.headers["HTTP_ACCEPT_LANGUAGE"]
    end
  end
end
