module Forms::Fields
  class RadioButtons < Field
    include OptionedField
  
    property :label, String, :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::RadioButtonsRenderer
  end
end
