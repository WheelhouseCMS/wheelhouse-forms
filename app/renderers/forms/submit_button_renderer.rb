class Forms::SubmitButtonRenderer < Forms::FieldRenderer
  def render
    template.recaptcha + content_tag(:div, submit_tag(label), :class => "field submit")
  end
end
