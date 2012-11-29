class Forms::FormRenderer
  include ActionView::Helpers::FormTagHelper
  
  attr_accessor :output_buffer
  
  def initialize(form)
    @form = form
  end
  
  def render(template)
    form_tag(@form.path) do
      concat @form.fields.to_html(template)
      concat default_submit_button unless has_submit_button?
    end
  end
  
  def protect_against_forgery?
    false
  end
  
  def controller
  end
  
private
  def has_submit_button?
    @form.fields.flatten.any? { |f| f.is_a?(Forms::Fields::SubmitButton) }
  end
  
  def default_submit_button
    content_tag(:div, submit_tag("Submit"), :class => "submit")
  end
end
