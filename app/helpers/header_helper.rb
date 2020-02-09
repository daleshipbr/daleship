# frozen_string_literal: true

module HeaderHelper
  def header_return(url, options = {})
    content_for :header_navigation_left do
      link_to url, options.merge!({ title: "Voltar" }) do
        image_tag "v4/icons/arrow-left-white.svg", alt: "Voltar"
      end
    end
  end

  def header_create(url, options = {})
    content_for :header_navigation_right do
      link_to url, title: options do
        tag.span class: "page-nav__create"
      end
    end
  end

  def header_title(text)
    content_for :header_title, text
  end
end
