class Forms::Mailer < ActionMailer::Base
  default :template_path => "form"
  
  def submission(form, submission)
    @form, @submission = form, submission
    
    mail(:to      => form.recipients,
         :from    => form.default_email_sender,
         :subject => form.subject)
  end
  
  def confirmation(form, submission)
    mail(:to      => submission.email,
         :from    => form.confirmation_email_sender,
         :subject => form.confirmation_email_subject,
         :body    => form.confirmation_email_body)
  end
end
