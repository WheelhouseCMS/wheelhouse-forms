module Forms::LabelledFieldRenderer
  def render(options={})
    super do
      result = ActiveSupport::SafeBuffer.new
      result << label_tag(name, field.label.html_safe) if field.label?
      result << yield if block_given?
      result
    end
  end
end
