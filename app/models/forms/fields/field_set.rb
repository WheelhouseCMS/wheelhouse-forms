module Forms::Fields
  class FieldSet < Field
    property :legend, String
    property :fields, Forms::FieldCollection
    
    validates_associated :fields

    def to_html(template)
      content_tag(:fieldset, :class => legend? ? legend.parameterize : '') do
        ActiveSupport::SafeBuffer.new.tap do |result|
          result << content_tag(:legend, legend) if legend?
          result << fields.to_html(template)
        end
      end
    end
    
    def to_ary
      fields
    end
  end
end
