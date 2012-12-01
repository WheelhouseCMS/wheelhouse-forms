module Forms::Fields
  class FieldSet < Field
    property :legend, String
    property :fields, Forms::FieldCollection
    
    validates_associated :fields
    
    self.renderer = Forms::FieldSetRenderer
    
    def to_ary
      fields
    end
  end
end
