class Forms::FieldSetRenderer < Forms::FieldRenderer
  def render(options={})
    content_tag(:fieldset, :class => field.legend? ? field.legend.parameterize : '') do
      ActiveSupport::SafeBuffer.new.tap do |result|
        result << content_tag(:legend, field.legend) if field.legend?
        result << field.fields.renderer.render(options)
      end
    end
  end
end
