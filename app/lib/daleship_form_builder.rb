# frozen_string_literal: true

class DaleshipFormBuilder < ActionView::Helpers::FormBuilder
  def labeled_field(attribute, type, options = {})
    klass = "required" if options[:required]
    width = "form__input--#{options.delete(:width)}" if options[:width]
    content = options.delete(:content)

    @template.content_tag "div", class: "form__input form__input--#{type} #{width}" do
      send("#{type}_field", attribute, options) + label(attribute, content, class: klass)
    end
  end

  def labeled_select(attribute, choices, options = {}, html_options = {}, &block)
    klass = "required" if options[:required]
    width = "form__input--#{options.delete(:width)}" if options[:width]

    @template.content_tag "div", class: "form__input #{width}" do
      select(attribute, choices, options, html_options, &block) + label(attribute, class: klass)
    end
  end

  def labeled_checkbox(attribute, content, options = {})
    width = "form__input--#{options.delete(:width)}" if options[:width]

    @template.content_tag "div", class: "form__input form__input--checkbox #{width}" do
      check_box(attribute, options) + label(attribute, content)
    end
  end

  def labeled_radio(attribute, content, options = {})
    width = "form__input--#{options.delete(:width)}" if options[:width]

    @template.content_tag "div", class: "form__input form__input--radio #{width}" do
      label(attribute, content) + radio_button(attribute, options)
    end
  end

  def cpf_cnpj_field(attribute, options = {})
    merge_cpf_cnpj_defaults(options)
    text_field(attribute, options)
  end

  def date_field(attribute, options = {})
    merge_date_defaults(options)
    text_field(attribute, options)
  end

  def file_field(attribute, options = {})
    super
  end

  def phone_field(attribute, options = {})
    merge_phone_defaults(options)
    text_field(attribute, options)
  end

  def email_field(attribute, options = {})
    merge_email_defaults(options)
    text_field(attribute, options)
  end

  def credit_card_field(attribute, options = {})
    merge_credit_card_defaults(options)
    text_field(attribute, options)
  end

  def decimal_field(attribute, options = {})
    merge_decimal_defaults(options)
    options["value"] = @template.number_with_precision self.object.send(attribute), precision: 2
    text_field(attribute, options)
  end

  def number_field(attribute, options = {})
    merge_number_defaults(options)
    text_field(attribute, options)
  end

  def text_field(attribute, options = {})
    merge_field_defaults(options)
    super
  end

  def password_field(attribute, options = {})
    merge_field_defaults(options)
    super
  end

  def sku_field(attribute, options)
    merge_sku_defaults(options)
    text_field(attribute, options)
  end

  def uri_field(attribute, options)
    merge_url_defaults(options)
    text_field(attribute, options)
  end

  def zipcode_field(attribute, options)
    merge_zipcode_defaults(options)
    text_field(attribute, options)
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    merge_select_defaults(html_options)
    super
  end

  def text_area(attribute, options = {})
    merge_text_area_defaults(options)
    super + counter_tag(attribute, options)
  end

  def counter_tag(attribute, options)
    return unless options["data"]["counter"] == true

    current = @object.send(attribute)&.length.to_i
    max = options["data"]["maxlength"].to_i
    id = tag_id(self.object, attribute, options[:index])
    klass = "field_with_errors" if current > max

    @template.tag.p "#{current}/#{max}", class: "txt-book txt-s14 txt-gray txt-rgh #{klass}", id: "#{id}_counter", data: { target: "form.counter" }
  end

  def stepper(attribute, text, options = {})
    color = options.delete(:color) || "orange"
    size = options.delete(:size) || "medium"

    @template.content_tag "div", class: "stepper stepper--#{color} stepper--#{size}", data: { controller: "steppers" } do
      if text.present?
        stepper_label(attribute, @template.raw(text), options[:index]) + stepper_input(attribute, options)
      else
        stepper_input(attribute, options)
      end
    end
  end

  def header(steps, title)
    @template.content_tag "div", class: "w-100p pv-12 ph-15" do
      (@template.content_tag "div", class: "w-100p h-50 flx flx-jc-btw flx-ai flx-wrp" do
        (@template.tag.button type: "button", class: "w-50 h-100p bg-arrow-left-gray invisible", data: { action: "form#previous", target: "form.previousButton" }) +
            (@template.tag.span "1/#{steps}", class: "txt-w600 txt-s12 txt-gray-darker", data: { target: "form.counter" }) +
            (@template.tag.div class: "w-50 invisible")
      end) + (@template.tag.span title, class: "h-40 txt-cnt txt-w600 txt-gray-darker txt-up block", data: { target: "form.title" })
    end
  end

  def steps
    @template.content_tag "div", class: "pos w-100p flx--fld" do
      yield
    end
  end

  def step(index, title, options = {})
    options.stringify_keys!
    options["class"] = "h-100p #{options["class"]}"
    options["data"] ||= {}
    options["data"].reverse_merge!(target: "form.step", "index": index, "title": title)

    @template.content_tag "div", options do
      yield
    end
  end

  def loading_step(options = {}, &block)
    options.stringify_keys!
    options["data"] = { target: "form.loadingStep" }

    step nil, nil, options, &block
  end

  def error_step(options = {}, &block)
    options.stringify_keys!
    options["data"] = { target: "form.errorStep" }

    step nil, nil, options, &block
  end

  def next_button(options = {})
    options.stringify_keys!
    options["class"] = "btn btn--s-purple #{options["class"]}"

    @template.tag.button "Continuar", type: "button", class: options["class"], data: { action: "form#next" }
  end

  private
  def merge_date_defaults(options)
    options["maxlength"] = 10
    options["formatter"] = :date
    options["pattern"] = "[0-9]*" if options[:pattern] == true
  end

  def merge_cpf_cnpj_defaults(options)
    options["maxlength"] = 14
    options["formatter"] = :numbers
    options["blur-formatter"] = :cpf_cnpj
    options["pattern"] = "[0-9]*" if options[:pattern] == true
  end

  def merge_phone_defaults(options)
    options["maxlength"] = 15
    options["formatter"] = :phone
    options["pattern"] = "[0-9]*" if options[:pattern] == true
  end

  def merge_credit_card_defaults(options)
    options["maxlength"] = 19
    options["formatter"] = :credit_card
    options["pattern"] = "[0-9]*" if options[:pattern] == true
  end

  def merge_decimal_defaults(options)
    options["maxlength"] = 12
    options["formatter"] = :decimal
  end

  def merge_email_defaults(options)
    options["validator"] = :email
    options["type"] = :email
  end

  def merge_number_defaults(options)
    options["formatter"] = :numbers
    options["pattern"] = "[0-9]*"
  end

  def merge_zipcode_defaults(options)
    options["maxlength"] = 9
    options["formatter"] = :zipcode
    options["pattern"] = "[0-9]*"
  end

  def merge_field_defaults(options)
    options.stringify_keys!
    options.reverse_merge!('class': "filled", 'maxlength': 255)
    options["data"] ||= {}
    options["data"].stringify_keys!

    options["data"]["target"] = "form.input #{options["data"]["target"]}"
    options["data"]["action"] = "input->form#input blur->form#blur #{options["data"]["action"]}"
    options["data"]["required"] = options.delete("required")
    options["data"]["formatter"] ||= options.delete("formatter")
    options["data"]["blur-formatter"] = options.delete("blur-formatter")
    options["data"].merge!({ "validator": options.delete("validator") })
  end

  def merge_select_defaults(options)
    options.stringify_keys!
    options.reverse_merge!('class': "filled")

    options["data"] ||= {}
    options["data"].reverse_merge!({ 'target': "form.change", 'action': "change->form#change" })
    options["data"].merge!({ "form-required": options.delete("required") })
  end

  def merge_sku_defaults(options)
    options["maxlength"] = 18
    options["formatter"] = :sku
  end

  def merge_url_defaults(options)
    options["formatter"] = :url
  end

  def merge_text_area_defaults(options)
    options.stringify_keys!

    options["data"] ||= {}
    options["data"].reverse_merge!({ 'target': "form.input", 'action': "input->form#input blur->form#blur" })
    options["data"]["required"] = options.delete("required")
    options["data"]["maxlength"] = options.delete("maxlength")
    options["data"]["counter"] = options.delete("counter")
  end

  def stepper_label(attribute, text, index)
    self.label attribute, text, class: "stepper__label", for: tag_id(self.object, attribute, index)
  end

  def stepper_input(attribute, options)
    name = "#{self.object.class.name.underscore}[#{attribute}]#{"[]" if options.delete(:array)}"
    id = tag_id(self.object, attribute, options.delete(:index)) if options[:index]
    value = self.object&.send(attribute)

    options.deep_stringify_keys!
    options.reverse_merge!(type: :number, value: value, name: name, id: id, placeholder: 0, maxlength: 1)
    options["data"] ||= {}
    options["data"]["formatter"] = :numbers
    options["data"]["target"] = "steppers.input #{options["data"]["target"]}"

    @template.content_tag "div", class: "stepper__input" do
      (@template.tag.button "-", type: "button", class: "decrease", data: { action: "steppers#decrease" }) +
          (self.text_field attribute, options) +
          (@template.tag.button "+", type: "button", class: "increase", data: { action: "steppers#increase" })
    end
  end

  def tag_id(object, attribute, index = nil)
    [object.class.name.underscore, attribute, index].reject(&:blank?).join "_"
  end
end
