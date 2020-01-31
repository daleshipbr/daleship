# frozen_string_literal: true

module SetLanguage
  extend ActiveSupport::Concern

  included do
    helper_method :language
  end

  private
  def language
    @language ||= LanguageAgent.new(Current.accept_language)
  end
end
