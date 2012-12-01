module Forms::Fields
  class CustomField < Field
    property :label, String, :required => true
    property :partial, String
    
    self.renderer = Forms::CustomFieldRenderer
  end
end
