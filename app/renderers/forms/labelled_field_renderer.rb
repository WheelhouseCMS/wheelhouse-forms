module Forms::LabelledFieldRenderer
  def render
    super do
      result = ActiveSupport::SafeBuffer.new
      result << label_tag(name, label) if field.label?
      result << yield if block_given?
      result
    end
  end
end
