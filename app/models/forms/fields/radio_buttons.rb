module Forms::Fields
  class RadioButtons < Field
    include LabelledField
    include OptionedField
  
    property :label, String
    property :required, Boolean, :default => false
  
    def to_html(template)
      super { content_tag(:ul, safe_join(options.map { |o| content_tag(:li, radio_button(o)) })) }
    end
  
  protected
    def radio_button(option)
      content_tag(:label, :class => "option #{option.parameterize}") do
        radio_button_tag(name, option, false, :id => nil) + " " + option
      end
    end
  end
end
