class Forms::ContentFieldRenderer < Forms::FieldRenderer
  def render(options={})
    field.content.to_s
  end
end
