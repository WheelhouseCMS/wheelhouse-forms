class Forms::FieldRenderer
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::OutputSafetyHelper
  
  attr_accessor :output_buffer
  attr_reader :field, :submission, :template
  
  def initialize(field, submission, template)
    @field, @submission, @template = field, submission, template
  end
  
  def render
    content_tag(:div, :class => classes.join(" ")) do
      concat yield if block_given?
      concat content_tag(:p, error, :class => "error") if has_errors?
    end
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
    classes << reference.parameterize
    classes << "required" if field.required?
    classes << "error" if has_errors?
    classes.uniq
  end
  
  def value
    submission.value_for(field) if submission
  end
  
  def has_errors?
    submission && submission.errors[field.label].any?
  end
  
  def error
    submission.errors[field.label].first
  end
  
  def html_options
    options = {}
    options[:required] = "required" if field.required?
    options
  end
end
