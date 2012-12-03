class Forms::TextFieldRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  def render
    super { text_field_tag(name, value, html_options.merge(:type => field.input_type)) }
  end
end
