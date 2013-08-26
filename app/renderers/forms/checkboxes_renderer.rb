class Forms::CheckboxesRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  def render
    super { content_tag(:ul, safe_join(list_items, "\n")) }
  end

protected
  def list_items
    field.options.map { |o| content_tag(:li, checkbox(o)) }
  end

  def checkbox(option)
    content_tag(:label, :class => "option #{option.parameterize}") do
      check_box_tag("#{name}[]", option, (value || []).include?(option), :id => nil) + " " + option.html_safe
    end
  end
end
