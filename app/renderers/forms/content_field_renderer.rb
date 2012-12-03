class Forms::ContentFieldRenderer < Forms::FieldRenderer
  def render
    field.content.to_s
  end
end
