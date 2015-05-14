class Forms::Form < Wheelhouse::Resource
  include Wheelhouse::Resource::Node
  include Wheelhouse::Resource::Renderable
  include Wheelhouse::Resource::Addressable
  include Wheelhouse::Resource::Versioned
  include Wheelhouse::Resource::Content
  
  property :title, String, :required => true, :translate => true
  property :fields, FieldCollection, :default => [Forms::Fields::FieldSet.new]
  
  property :submission_notification, Boolean, :default => true
  property :notification_email_sender, String
  property :notification_email_recipients, MongoModel::Collection[String], :as => 'recipients'
  property :notification_email_subject, String, :default => "Form Submission", :as => 'subject'
  
  property :confirmation_email, Boolean, :default => false
  property :confirmation_email_sender, String
  property :confirmation_email_subject, String
  property :confirmation_email_body, String
  
  validates_associated :fields
  
  has_many :submissions, :class => "Forms::Submission"
  
  activities :all
  
  icon "wheelhouse-forms/form.png"
  
  attr_accessor :view_context, :current_submission, :success
  
  def to_s
    render(view_context)
  end
  
  def render(template)
    Forms::FormRenderer.new(self, current_submission, template).render
  end
  
  def submit(params, request)
    submission = submissions.build(:params => params, :ip_address => request.remote_ip)
    Forms::Plugin.config.wheelhouse.forms.spam_filter.check(submission)
    
    if submission.save
      deliver(submission) unless submission.spam?
      self.success = true
    else
      self.current_submission = submission
      self.success = false
    end
  end

  def notification_email_sender
    read_attribute(:notification_email_sender).presence || default_email_sender
  end

  def confirmation_email_sender
    read_attribute(:confirmation_email_sender).presence || default_email_sender
  end
  
  def default_email_sender
    "noreply@#{site.domain}"
  end
  
  def deliver(submission)
    Forms::Mailer.submission(self, submission).deliver if deliver_submission_notification?
    Forms::Mailer.confirmation(self, submission).deliver if deliver_confirmation_email?(submission)
  rescue
    # Mail delivery failed
  end
  
  def success?
    @success
  end
  
  def first_content_field
    @first_content_field ||= fields.flatten.find { |f| f.respond_to?(:label) }
  end
  
  def notification_email_recipients=(recipients)
    recipients = recipients.split(/,/) if recipients.is_a?(String)
    write_attribute(:notification_email_recipients, recipients.map(&:strip))
  end
  
  def handler
    Forms::FormHandler
  end

protected
  def deliver_submission_notification?
    submission_notification? && notification_email_recipients.any?
  end
  
  def deliver_confirmation_email?(submission)
    confirmation_email? && submission.email.present?
  end
end
