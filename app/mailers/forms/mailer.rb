class Forms::Mailer < ActionMailer::Base
  default :template_path => "form"
  
  def submission(form, submission)
    @form, @submission = form, submission
    
    mail(:to       => form.notification_email_recipients,
         :from     => form.notification_email_sender,
         :subject  => form.notification_email_subject,
         :reply_to => submission.email)
  end
  
  def confirmation(form, submission)
    mail(:to      => submission.email,
         :from    => form.confirmation_email_sender,
         :subject => form.confirmation_email_subject,
         :body    => form.confirmation_email_body)
  end
end
