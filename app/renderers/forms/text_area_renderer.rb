class Forms::TextAreaRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  def render(options={})
    super { text_area_tag(name, nil, html_options) }
  end
end
