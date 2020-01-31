# frozen_string_literal: true

module Permission
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    elsif user.admin?
      AdminPermission.new
    elsif user.partner?
      CompanyPermission.new(user)
    else
      UserPermission.new(user)
    end
  end
end
