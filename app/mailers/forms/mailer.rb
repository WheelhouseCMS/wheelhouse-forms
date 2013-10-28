class Forms::Mailer < ActionMailer::Base
  default :template_path => "form"
  
  def submission(form, submission)
    @form, @submission = form, submission
    
    mail(:from    => form.email_sender,
         :to      => form.recipients,
         :subject => form.subject)
  end
  
  def confirmation(form, submission)
    mail(:from    => form.email_sender,
         :to      => submission.email,
         :subject => form.confirmation_email_subject,
         :body    => form.confirmation_email_body)
  end
end
