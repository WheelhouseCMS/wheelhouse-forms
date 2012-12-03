class Forms::CheckboxRenderer < Forms::FieldRenderer
  def render
    super do
      label_tag { check_box_tag(name, "Yes", value, html_options) + " " + field.label }
    end
  end
end
