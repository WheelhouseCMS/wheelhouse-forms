module Forms::SubmissionsHelper
  def render_field(field)
    case field
    when Forms::Fields::FieldSet
      render_fieldset(field)
    when Forms::Fields::CustomField
      render_custom_field(field)
    when Forms::Fields::Checkboxes
      labelled_field(field) do
        value = @submission.value_for(field)
        render_array(field, value || [""])
      end
    when Forms::Fields::TextArea
      labelled_field(field) do
        value = @submission.value_for(field)
        form.text_area field.label, :value => value || "", :readonly => true, :rows => 5
      end
    when Forms::Fields::ContentField, Forms::Fields::SubmitButton
      # Nothing
    else
      labelled_field(field) do
        value = @submission.value_for(field)
        form.text_field field.label, :value => value || "", :readonly => true
      end
    end
  end

private
  def labelled_field(field)
    field(field.label, :label => field.label.html_safe) do
      yield
    end
  end

  def render_fieldset(fieldset)
    content_tag(:div, :class => "shaded") do
      concat content_tag(:h2, fieldset.legend) if fieldset.legend?
      concat safe_join(fieldset.fields.map { |f| render_field(f) })
      nil
    end
  end
  
  def render_custom_field(field)
    labelled_field(field) do
      value = @submission.value_for(field)
      
      case value
      when Array
        render_array(field, value)
      when Hash
        render_hash(field, value)
      else
        form.text_field field.label, :value => value || "", :readonly => true
      end
    end
  end
  
  def render_array(field, array)
    content_tag(:ul, safe_join(array.map { |value|
      content_tag(:li, form.text_field("#{field.label}[]", :value => value || "", :readonly => true))
    }))
  end
  
  def render_hash(field, hash)
    content_tag(:div, :class => "inline") do
      safe_join(hash.map { |key, value|
        form.label("#{field.label} #{key}", key) + form.text_field("#{field.label} #{key}", :value => value || "", :readonly => true, :size => nil)
      })
    end
  end
end
