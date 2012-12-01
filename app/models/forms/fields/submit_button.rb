module Forms::Fields
  class SubmitButton < Field
    property :label, String, :default => "Submit", :required => true
    
    self.renderer = Forms::SubmitButtonRenderer
  end
end
