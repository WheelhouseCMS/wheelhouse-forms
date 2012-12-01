class Forms::CheckboxRenderer < Forms::FieldRenderer
  def render(options={})
    super do
      label_tag { check_box_tag(name, "1", false, html_options) + " " + field.label }
    end
  end
end
