class Forms::CustomFieldRenderer < Forms::FieldRenderer
  def render
    super { template.render :partial => field.partial, :locals => { :field => field } }
  end
end
