module Forms::Fields
  class SubmitButton < Field
    property :label, String, :default => "Submit"
    
    def to_html(template)
      super { submit_tag(label) }
    end
  
  protected
    def classes
      ["field", "submit"]
    end
  end
end
