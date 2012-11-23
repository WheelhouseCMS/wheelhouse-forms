class Forms::Submission < Wheelhouse::BasicResource
  class Parameters < Hash
    def to_mongo
      result = []
      each do |key, value|
        result << [key, value]
      end
      result
    end
    
    def self.cast(params)
      case params
      when Hash
        self[params]
      when Array
        self[*params.flatten]
      end
    end
    
    def self.from_mongo(params)
      cast(params)
    end
  end
  
  include Wheelhouse::Resource::AdminPath
  
  property :params, Parameters
  timestamps!
  
  belongs_to :form, :class => "Forms::Form"
  
  default_scope order(:created_at.desc)
  
  def value_for(field)
    params[field.label]
  end
  
  def admin_path
    form_submission_path(form_id, id)
  end
  
  def admin_url
    form_submission_url(form, id, :host => form.site.domain)
  end
end
