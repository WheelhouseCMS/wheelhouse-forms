class Forms::CheckboxRenderer < Forms::FieldRenderer
  def render
    super do
      label_tag { check_box_tag(name, "1", value, html_options) + " " + field.label }
    end
  end
end
