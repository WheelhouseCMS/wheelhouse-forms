class Forms::FieldSetRenderer < Forms::FieldRenderer
  def render
    content_tag(:fieldset, :class => field.legend? ? field.legend.parameterize : '') do
      ActiveSupport::SafeBuffer.new.tap do |result|
        result << content_tag(:legend, field.legend.html_safe) if field.legend?
        result << field.fields.render(submission, template)
      end
    end
  end
end
