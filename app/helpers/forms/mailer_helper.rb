module Forms::MailerHelper
  def render_field(field)
    case field
    when Forms::Fields::FieldSet
      render_fieldset(field)
    when Forms::Fields::CustomField
      render_custom_field(field)
    when Forms::Fields::Checkboxes
      render_array(field, @submission.value_for(field) || ["None given"])
    when Forms::Fields::ContentField, Forms::Fields::SubmitButton
      # Nothing
    else
      render_text_field(field, @submission.value_for(field))
    end
  end
  
private
  def render_fieldset(fieldset)
    content_tag(:div, :class => "fieldset") do
      concat content_tag(:h3, fieldset.legend) if fieldset.legend?
      concat safe_join(fieldset.fields.map { |f| render_field(f) }, "\n")
      nil
    end
  end
  
  def render_custom_field(field)
    value = @submission.value_for(field)
    
    case value
    when Array
      render_array(field, value)
    when Hash
      render_hash(field, value)
    else
      render_text_field(field, value)
    end
  end
  
  def render_array(field, array)
    labelled_field(field) do
      concat content_tag(:ul, safe_join(array.map { |i| content_tag(:li, i) }))
    end
  end
  
  def render_hash(field, hash)
    labelled_field(field) do
      concat content_tag(:ul, safe_join(hash.map { |k, v|
        content_tag(:li, content_tag(:strong, k) + ": " + v)
      }))
    end
  end
  
  def render_text_field(field, value)
    labelled_field(field) do
      concat field.is_a?(Forms::Fields::TextArea) ? tag(:br) : " "
      concat value
    end
  end
  
  def labelled_field(field)
    content_tag(:p, :class => "field") do
      concat content_tag(:strong, field.label + ":")
      yield
      nil
    end
  end
end
