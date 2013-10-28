class Forms::Submission < Wheelhouse::BasicResource
  include Wheelhouse::Resource::AdminPath
  
  property :params, Parameters
  property :ip_address, String
  property :spam, Boolean, :default => false, :protected => true
  timestamps!
  
  belongs_to :form, :class => "Forms::Form"
  
  default_scope order(:created_at.desc)
  
  scope :spam, where(:spam => true)
  scope :not_spam, where(:spam.ne => true)
  
  validate do
    form.fields.flatten.each do |field|
      if field.required? && value_for(field).blank?
        errors.add(field.label, "This field is required")
      end
    end
  end
  
  def email
    params.find { |label, value| label =~ /e-?mail/i }.last
  end
  
  def spam!(is_spam)
    Forms::Plugin.config.wheelhouse.forms.spam_filter.train(self, is_spam)
    update_attribute(:spam, is_spam)
  end
  
  def value_for(field)
    params[field.label] if field.respond_to?(:label)
  end
  
  def admin_path
    form_submission_path(form_id, id)
  end
  
  def admin_url
    form_submission_url(form, id, :host => form.site.domain)
  end
end
