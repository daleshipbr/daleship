# frozen_string_literal: true

module PageHelper
  def page_title(text)
    title strip_tags(text)
    header_title text
    content_for :page_title, text.html_safe
  end

  def page_custom_title(text, title, subtitle)
    page_title(text)

    content_for :page_variant_title do
      concat tag.h2 subtitle, class: "master-nav__subtitle"
      concat tag.h1 title, class: "master-nav__title"
    end
  end

  def page_return(url, options = {})
    content_for :page_navigation_left do
      link_to url, options.merge!({ title: "Voltar" }) do
        image_tag "v4/icons/arrow-left-white.svg", alt: "Voltar"
      end
    end
  end

  def page_custom_return(url)
    content_for :page_navigation_left, url
  end

  def page_has_custom_navigation
    content_for :page_custom_navigation, true
  end
end
