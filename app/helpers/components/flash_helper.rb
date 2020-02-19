# frozen_string_literal: true

module Components::FlashHelper
  def flash_tag(style, options = {})
    return unless (type = flash.keys.first)
    message = flash[type]
    flash.clear

    options.stringify_keys!
    options["class"] = "flash flash--#{style} flash--#{type} #{options["class"]}"
    options["data"] = { controller: "flash", "flash-style": style }

    content_tag "div", options do
      tag.span message, class: "flash__message"
    end
  end

  def flash_tag_js
    "document.body.insertAdjacentHTML('beforeend', '#{j flash_tag "temporary"}');".html_safe
  end
end
