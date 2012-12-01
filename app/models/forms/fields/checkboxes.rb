module Forms::Fields
  class Checkboxes < Field
    include OptionedField
  
    property :label, String, :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::CheckboxesRenderer
  end
end
