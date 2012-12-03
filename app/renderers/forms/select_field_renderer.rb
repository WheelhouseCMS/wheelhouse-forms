class Forms::SelectFieldRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  include ActionView::Helpers::FormOptionsHelper
  
  def render
    super { select_tag(name, options_for_select(field.options, value), html_options) }
  end
end
