class Forms::SelectFieldRenderer < Forms::FieldRenderer
  include Forms::LabelledFieldRenderer
  
  include ActionView::Helpers::FormOptionsHelper
  
  def render(options={})
    super { select_tag(name, options_for_select(field.options), html_options) }
  end
end
