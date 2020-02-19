# frozen_string_literal: true

module Permission
  class GuestPermission < BasePermission
    def initialize
      allow "sessions", [:new, :create]
    end
  end
end
