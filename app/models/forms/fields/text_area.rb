module Forms::Fields
  class TextArea < Field
    property :label, String, :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::TextAreaRenderer
  end
end
