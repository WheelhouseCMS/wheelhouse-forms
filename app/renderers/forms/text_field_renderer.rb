class Forms::TextFieldRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  def render(options={})
    super { text_field_tag(name, nil, html_options) }
  end
end