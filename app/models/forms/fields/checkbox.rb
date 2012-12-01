module Forms::Fields
  class Checkbox < Field
    property :label, String, :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::CheckboxRenderer
  end
end
