# frozen_string_literal: true

# TODO this is all an example, don't forget to do it

module Permission
  class UserPermission < GuestPermission
    def initialize(user)
      allow_all
    end
end
