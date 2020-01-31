# frozen_string_literal: true

module Components::FormsHelper
  class ActionView::Helpers::FormBuilder
    include ActionView::Helpers::Tags

    def errors(name)
      if @object.errors.any?
        if !@object.errors.messages[name].blank?
          msg = @object.errors.messages[name].first
          msg = msg.slice(0, 1).capitalize + msg.slice(1..-1)
          "<span class='error'>#{msg}</span>".html_safe
        end
      end
    end
  end

  def daleship_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
    options.reverse_merge! builder: DaleshipFormBuilder, class: "form", data: { controller: "form", action: "done->form#done loading->form#loading" }, html: { novalidate: true }

    form_with model: model, scope: scope, url: url, format: format, **options do |form|
      concat flash_tag("form", class: "mb-18")
      concat block.call(form)
    end
  end

  def input_group_date(form, object, attribute, options = {})
    options = options.stringify_keys

    capture do
      concat input_group_date_content(form, object, attribute, options)
      concat form.errors attribute
    end
  end

  def input_group_time(form, object, attribute, options = {})
    options = options.stringify_keys

    capture do
      concat input_group_time_content(form, object, attribute, options)
      concat form.errors attribute
    end
  end

  def input_group_text_field(form, object, attribute, options = {})
    options = options.stringify_keys

    capture do
      concat input_group_text_field_content(form, object, attribute, options)
      concat form.errors attribute
    end
  end

  def input_group_textarea(form, object, attribute, options = {})
    options = options.stringify_keys

    capture do
      concat input_group_textarea_content(form, object, attribute, options)
      concat form.errors attribute
    end
  end

  private
  def input_group_date_content(form, object, attribute, options)
    options["data"] ||= {}
    options["data"]["formatter"] = "date"
    options["maxlength"] = 10
    options["value"] = object.send(attribute)&.x_date

    content_tag "div", class: "input-group input-group--date mb-6" do
      concat(input_group_label(object, attribute, options))
      concat(form.text_field attribute, options)
    end
  end

  def input_group_time_content(form, object, attribute, options)
    content_tag "div", class: "input-group input-group--time mb-6" do
      concat(input_group_label(object, attribute, options))
      concat(form.select attribute, hours_options, include_blank: true)
    end
  end

  def input_group_text_field_content(form, object, attribute, options)
    content_tag "div", class: "input-group input-group--text mb-6" do
      concat(input_group_label(object, attribute, options))
      concat(form.text_field attribute, options)
    end
  end

  def input_group_textarea_content(form, object, attribute, options)
    content_tag "div", class: "input-group input-group--text mb-6" do
      concat(input_group_label(object, attribute, options))
      concat(form.text_area attribute, options)
    end
  end

  def input_group_label(object, attribute, options)
    content_tag "h3" do
      concat(options["name"] || object.class.human_attribute_name(attribute))
      concat(tag.small "#{object.send(attribute).length}/#{options["maxlength"]}", class: "input-group__counter", data: { "input-group-counter": true }) if show_counter?(options)
    end
  end

  def show_counter?(options)
    options["counter"] == "true"
  end
end
