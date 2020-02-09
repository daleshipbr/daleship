# frozen_string_literal: true

require "i18n"

module ApplicationHelper
  def title(text)
    content_for :title, text
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text = "")
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def to_seo_text(text)
    I18n.transliterate text
  end

  def headless?
    params[:mode] == "headless"
  end

  def preview?
    params[:mode] == "preview"
  end

  def edit?
    params[:mode] == "edit"
  end

  def no_index
    content_for :noindex, true
  end

  def no_cache
    content_for :header do
      tag.meta name: "turbolinks-cache-control", content: "no-cache"
    end
  end
end
