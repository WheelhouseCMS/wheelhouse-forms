module Forms::Fields
  class TextField < Field
    property :label, String, :required => true
    property :input_type, String, :default => "text"
    property :required, Boolean, :default => false
    
    self.renderer = Forms::TextFieldRenderer
    
    INPUT_TYPES = [
      ["Text",        "text"],
      ["Email",       "email"],
      ["Telephone",   "tel"],
      ["URL",         "url"],
      ["Date",        "date"],
      ["Date & Time", "datetime"],
      ["Number",      "number"],
      ["Search",      "search"],
      ["Color",       "color"]
    ]
  end
end
