module Forms::Fields
  class Field < Wheelhouse::EmbeddedResource
    class_attribute :renderer
    self.renderer = Forms::FieldRenderer
    
    def renderer
      self.class.renderer.new(self)
    end
    
    def required?
      read_attribute(:required)
    end
    
    def self.partial
      name.demodulize.underscore
    end
    
    def self.cast(attrs)
      case attrs
      when Hash
        type = attrs.delete('type')
        Forms::Fields.const_get(type).new(attrs)
      else
        super
      end
    end
  end
end
