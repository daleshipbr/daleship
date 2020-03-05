# frozen_string_literal: true

module Permission
  class GuestPermission < BasePermission
    def initialize
      allow_all
    end
  end
end
