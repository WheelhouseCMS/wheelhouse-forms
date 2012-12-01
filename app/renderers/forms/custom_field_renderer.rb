class Forms::CustomFieldRenderer < Forms::FieldRenderer
  def render(options={})
    super { options[:template].render :partial => field.partial, :locals => { :field => field } }
  end
end
