# frozen_string_literal: true

module Redirection
  extend ActiveSupport::Concern

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def redirect_back_or_home
    redirect_back_or user_home
  end

  def redirect_home
    redirect_to user_home
  end

  def redirect_home_if_logged
    redirect_home if Current.user.present?
  end

  def store_location(url = nil)
    session[:forwarding_url] = url || original_url
  end

  private
  def original_url
    return unless request.get?
    return if request.original_url.ends_with?("login")
    return if request.original_url.ends_with?("cadastrar")

    request.original_url
  end

  def user_home
    if Current.user.blank?
      root_path
    elsif Current.user.admin?
      admin_home
    elsif Current.user.partner?
      partner_home
    else
      case Current.user.events_count
      when 0
        invitation_templates_path
      when 1 # TODO: Figure out why I keep getting 0 active events even when this is one
        event = Current.user.events.active.first
        event ? event_path(event, anchor: "switcher") : events_path
      else
        events_path
      end
    end
  end

  def partner_home
    if Current.user.partner.buffet?
      company_buffets_dashboard_path(Current.user.partner)
    else
      events_path
    end
  end

  def admin_home
    admin_events_path
  end
end
