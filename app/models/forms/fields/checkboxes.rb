module Forms::Fields
  class Checkboxes < Field
    include LabelledField
    include OptionedField
  
    property :label, String
    property :required, Boolean, :default => false
  
    def to_html(template)
      super { content_tag(:ul, safe_join(options.map { |o| content_tag(:li, checkbox(o)) })) }
    end
  
  protected
    def checkbox(option)
      content_tag(:label, :class => "option #{option.parameterize}") do
        check_box_tag("#{name}[]", option, false, :id => nil) + " " + option
      end
    end
  end
end
