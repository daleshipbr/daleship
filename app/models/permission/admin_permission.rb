# frozen_string_literal: true

module Permission
  class AdminPermission < BasePermission
    def initialize
      allow_all
    end
  end
end
