# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :account, :user
  attribute :request_id, :user_agent, :ip_address
  attribute :accept_language
end
