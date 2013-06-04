class Forms::Submission < Wheelhouse::BasicResource
  include Wheelhouse::Resource::AdminPath
  
  property :params, Parameters
  property :ip_address, String
  property :is_spam, Boolean, :default => false, :protected => true
  timestamps!
  
  belongs_to :form, :class => "Forms::Form"
  
  default_scope order(:created_at.desc)
  
  scope :spam, where(:is_spam => true)
  scope :not_spam, where(:is_spam.ne => true)
  
  validate do
    form.fields.flatten.each do |field|
      if field.required? && value_for(field).blank?
        errors.add(field.label, "This field is required")
      end
    end
  end
  
  def set_spam_flag!(is_spam)
    update_attribute(:is_spam, is_spam)
  end
  
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
