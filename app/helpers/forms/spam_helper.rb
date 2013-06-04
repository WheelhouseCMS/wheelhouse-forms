module Forms::SpamHelper
  def spam_icon
    icon("wheelhouse-forms/spam.png", :alt => "Mark as spam", :title => "Click to mark submission as spam")
  end
  
  def not_spam_icon
    icon("wheelhouse-forms/not-spam.png", :alt => "Mark as not spam", :title => "Click to mark submission as not spam")
  end
  
  def toggle_spam_link(submission, path)
    if submission.is_spam?
      link_to not_spam_icon, path, :class => "not-spam"
    else
      link_to spam_icon, path, :class => "mark-spam"
    end
  end
  
  def listing_spam?
    controller.action_name == "spam"
  end
end
