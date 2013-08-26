class Forms::SubmitButtonRenderer < Forms::FieldRenderer
  def render
    content_tag(:div, submit_tag(label), :class => "field submit")
  end
end
