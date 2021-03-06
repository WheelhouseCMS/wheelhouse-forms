class Forms::RadioButtonsRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  def render
    super { content_tag(:ul, safe_join(list_items, "\n")) }
  end

protected
  def list_items
    field.options.map { |o| content_tag(:li, radio_button(o)) }
  end

  def radio_button(option)
    content_tag(:label, :class => "option #{option.parameterize}") do
      radio_button_tag(name, option, value == option, :id => nil) + " " + option.html_safe
    end
  end
end
