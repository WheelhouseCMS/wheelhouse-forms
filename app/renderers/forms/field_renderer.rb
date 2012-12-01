class Forms::FieldRenderer
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::OutputSafetyHelper
  
  attr_accessor :output_buffer
  attr_reader :field
  
  def initialize(field)
    @field = field
  end
  
  def render(options={})
    content_tag(:div, :class => classes.join(" ")) { yield if block_given? }
  end

protected
  def name
    "submission[#{reference}]"
  end
  
  def reference
    field.label
  end
  
  def field_class
    field.class.partial.dasherize
  end
  
  def classes
    classes = ["field", field_class]
    classes << "required" if field.required?
    classes << field.reference.parameterize if field.respond_to?(:reference)
    classes
  end
  
  def html_options
    options = {}
    options[:required] = "required" if field.required?
    options
  end
end
