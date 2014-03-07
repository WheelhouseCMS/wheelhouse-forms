module Forms::FormsHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    def initialize(field, prefix, template)
      if ActionPack::VERSION::STRING >= "4.0.0"
        super(prefix, field, template, {})
      else
        super(prefix, field, template, {}, nil)
      end
    end
    
    def required_field_checkbox
      @template.content_tag(:label, :class => "required") do
        check_box(:required, :id => nil) + " This field is required"
      end
    end
  end
  
  def form_field(field, options={}, &block)
    builder = FormBuilder.new(field, options[:prefix], self)
    
    content_tag(:div, :class => options[:class], :data => { :index => options[:index] }) do
      concat builder.hidden_field(:type, :value => field.type.demodulize, :id => nil)
      
      concat content_tag(:div, form_field_icon(field, options), :class => "drag")
      
      concat content_tag(:div, capture(builder, &block), :class => "drag-area")
      
      concat link_to("Delete", '#', :class => 'delete')
    end
  end
  
  def render_fields(fields, prefix)
    fields.map_with_index do |field, index|
      render(:partial => field.class.partial, :object => field, :locals => { :index => index, :prefix => "#{prefix}[#{index}]" })
    end.join("\n").html_safe
  end
  
  def field_template(id, klass)
    jquery_template_tag(id) do
      render :partial => klass.partial, :object => klass.new, :locals => { :index => "${index}", :prefix => "${prefix}" }
    end
  end
  
  def form_field_icon(field, options)
    model_name = field.class.model_name
    icon = options[:icon] || model_name.to_s.demodulize.underscore.dasherize
    image_tag("wheelhouse-forms/#{icon}.png", :alt => model_name.human, :title => model_name.human)
  end
end
