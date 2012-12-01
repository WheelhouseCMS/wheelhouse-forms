module Forms::Fields
  class SelectField < Field
    include OptionedField

    property :label, String, :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::SelectFieldRenderer
  end
end
