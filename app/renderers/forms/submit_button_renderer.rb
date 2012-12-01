class Forms::SubmitButtonRenderer < Forms::FieldRenderer
  def render(options={})
    content_tag(:div, submit_tag(field.label), :class => "field submit")
  end
end
