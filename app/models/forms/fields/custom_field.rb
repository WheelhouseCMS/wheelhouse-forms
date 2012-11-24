module Forms::Fields
  class CustomField < Field
    property :label, String, :required => true
    property :partial, String

    def to_html(template)
      super { template.render :partial => partial, :locals => { :field => self } }
    end
  
    def reference
      label
    end
  end
end
