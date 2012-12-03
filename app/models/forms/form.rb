class Forms::Form < Wheelhouse::Resource
  include Wheelhouse::Resource::Node
  include Wheelhouse::Resource::Renderable
  include Wheelhouse::Resource::Addressable
  include Wheelhouse::Resource::Versioned
  include Wheelhouse::Resource::Content
  
  property :title, String, :required => true, :translate => true
  property :fields, FieldCollection, :default => [Forms::Fields::FieldSet.new]
  property :recipients, MongoModel::Collection[String]
  property :subject, String, :default => "Form Submission"
  
  validates_associated :fields
  
  has_many :submissions, :class => "Forms::Submission"
  
  activities :all
  
  icon "wheelhouse-forms/form.png"
  
  attr_accessor :view_context, :current_submission
  
  def to_s
    render(view_context)
  end
  
  def render(template)
    Forms::FormRenderer.new(self, current_submission, template).render
  end
  
  def submit(params)
    submission = submissions.build(:params => params)
    
    if submission.save
      deliver(submission)
      @success = true
    else
      self.current_submission = submission
      @success = false
    end
  end
  
  def deliver(submission)
    Forms::Mailer.submission(self, submission).deliver unless recipients.empty?
  rescue
    # Mail delivery failed
  end
  
  def success?
    @success
  end
  
  def first_content_field
    @first_content_field ||= fields.flatten.find { |f| f.respond_to?(:label) }
  end
  
  def recipients=(recipients)
    recipients = recipients.split(/,/) if recipients.is_a?(String)
    write_attribute(:recipients, recipients.map(&:strip))
  end
  
  def handler
    Forms::FormHandler
  end
end
