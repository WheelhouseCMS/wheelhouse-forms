class Forms::FormRenderer
  include ActionView::Helpers::FormTagHelper

  attr_accessor :output_buffer
  attr_reader :form
  
  def initialize(form)
    @form = form
  end
  
  def render(options={})
    form_tag(form.path) do
      concat form.fields.renderer.render(options)
      concat default_submit_button unless has_submit_button?
    end
  end
  
  def protect_against_forgery?
    false
  end
  
private
  def has_submit_button?
    form.fields.flatten.any? { |f| f.is_a?(Forms::Fields::SubmitButton) }
  end
  
  def default_submit_button
    content_tag(:div, submit_tag("Submit"), :class => "submit")
  end
end
