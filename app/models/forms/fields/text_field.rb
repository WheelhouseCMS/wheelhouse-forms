module Forms::Fields
  class TextField < Field
    property :label, String, :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::TextFieldRenderer
  end
end
