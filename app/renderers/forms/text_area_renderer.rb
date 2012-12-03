class Forms::TextAreaRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  def render
    super { text_area_tag(name, value, html_options) }
  end
end
